"use strict";

const {
  BadRequestError,
  InternalServerError,
  AuthFailureError,
} = require("../core/error.response");
const userModel = require("../models/user.model");
const { getInfoData } = require("../utils");
const crypto = require("crypto");
const KeyTokenService = require("./keytoken.service");
const { createTokenPair } = require("../auth/authUtils");
const { Types } = require("mongoose");
const Email = require("../utils/email");
const generateOTPConfig = require("../utils/generateOTP.config");
const EXPIRES_TIME = 10 * 60 * 1000;

class AuthenService {
  static resetPassword = async ({
    body: { password, passwordConfirm },
    params,
  }) => {
    const passwordResetToken = crypto
      .createHash("sha256")
      .update(params.token)
      .digest("hex");
    const user = await userModel.findOne({
      passwordResetToken,
      passwordResetExpires: { $gt: Date.now() },
    });
    if (!user) {
      throw new BadRequestError("Your token is invalid or has expired.");
    }

    if (password !== passwordConfirm) {
      throw new AuthFailureError("Passwords do not match! Please try again!");
    }

    user.passwordResetToken = undefined;
    user.passwordResetExpires = undefined;

    user.password = password;
    await user.save({ validateBeforeSave: false });

    const publicKey = crypto.randomBytes(64).toString("hex");
    const privateKey = crypto.randomBytes(64).toString("hex");

    const keytoken = await KeyTokenService.createKeyToken({
      user: new Types.ObjectId(user._id),
      privateKey,
      publicKey,
    });

    if (!keytoken) {
      throw new BadRequestError("Keytoken Error");
    }

    const tokens = await createTokenPair(
      { userId: user._id, email: user.email },
      publicKey,
      privateKey
    );
    return {
      message: "Reset Password Successfully!",
      metadata: {
        user: getInfoData({ object: user, fields: ["_id", "name", "email"] }),
        tokens,
      },
    };
  };
  static verifyOTP = async ({ email, OTP }) => {
    const user = await userModel.findOne({
      email,
      OTPExpires: { $gt: Date.now() },
    });
    if (!user) {
      throw new BadRequestError(
        "There is no user with email address or OTP has expired!"
      );
    }

    if (user.OTP !== OTP) {
      throw new AuthFailureError(
        "Your entered OTP is invalid! Please try again!"
      );
    }

    user.OTP = undefined;
    user.OTPExpires = undefined;
    await user.save({ validateBeforeSave: false });
    const resetToken = crypto.randomBytes(32).toString("hex");

    const passwordResetToken = crypto
      .createHash("sha256")
      .update(resetToken)
      .digest("hex");
    const passwordResetExpires = Date.now() + EXPIRES_TIME; // 10p hiệu lực

    await userModel.findOneAndUpdate(
      { _id: new Types.ObjectId(user._id) },
      { passwordResetToken, passwordResetExpires },
      { new: true }
    );
    return {
      message: "Verify OTP successfully!",
      metadata: {
        resetURL: `http://localhost:${process.env.PORT}/api/v1/resetPassword/${resetToken}`,
      },
    };
  };
  static forgotPassword = async ({ email }) => {
    const user = await userModel.findOne({ email });
    if (!user) {
      throw new BadRequestError("There is no user with email address!");
    }

    const OTP = generateOTPConfig(4);
    user.OTP = OTP;
    user.OTPExpires = Date.now() + EXPIRES_TIME;
    await user.save({ validateBeforeSave: false });
    try {
      await new Email({ email, OTP }).sendEmail();
    } catch (error) {
      user.passwordResetToken = undefined;
      user.passwordResetExpires = undefined;
      user.save({ validateBeforeSave: false });

      throw new InternalServerError(
        "There was an error sending the email. Try again later!"
      );
    }

    return {
      message: "OTP sent to email!",
    };
  };
  static logOut = async (keyStore) => {
    const delKey = await KeyTokenService.removeKeyById(keyStore._id);
    console.log({ delKey });
    return delKey;
  };
  static signUp = async ({ name, email, password, passwordConfirm, role }) => {
    if (!name || !email || !password || !passwordConfirm) {
      throw new BadRequestError("Error: Please fill all the fields!");
    }
    const existingUser = await userModel.findOne({ email }).lean();
    if (existingUser) {
      throw new BadRequestError("Error: User already registered!");
    }

    const newUser = await userModel.create({
      name,
      email,
      password,
      passwordConfirm,
      role,
    });

    if (newUser) {
      // tạo private key và public key
      const privateKey = crypto.randomBytes(64).toString("hex");
      const publicKey = crypto.randomBytes(64).toString("hex");

      // tạo keytoken model mới
      const newkeytoken = await KeyTokenService.createKeyToken({
        userId: newUser._id,
        publicKey,
        privateKey,
      });

      if (!newkeytoken) {
        throw new BadRequestError("Keytoken Error");
      }

      const tokens = await createTokenPair(
        { userId: newUser._id, email },
        publicKey,
        privateKey
      );
      console.log("Create Token Successfully!", tokens);
      return {
        statusCode: 201,
        message: "Sign up successfully!",
        metadata: {
          user: getInfoData({
            object: newUser,
            fields: ["_id", "name", "email"],
          }),
          tokens,
        },
      };
    }
    return {
      statusCode: 200,
      metadata: null,
    };
  };

  static logIn = async ({ email, password }) => {
    if (!email || !password) {
      throw new BadRequestError("Error: Please enter email or password!");
    }

    const user = await userModel.findOne({ email });
    if (!user || !(await user.matchPassword(password))) {
      throw new AuthFailureError("Error: Incorrect email or password!");
    }

    // tạo private key và public key
    const privateKey = crypto.randomBytes(64).toString("hex");
    const publicKey = crypto.randomBytes(64).toString("hex");

    const tokens = await createTokenPair(
      { userId: user._id, email },
      publicKey,
      privateKey
    );

    await KeyTokenService.createKeyToken({
      userId: user._id,
      refreshToken: tokens.refreshToken,
      privateKey,
      publicKey,
    });

    return {
      statusCode: 200,
      message: "Log in successfully!",
      metadata: {
        user: getInfoData({ object: user, fields: ["_id", "name", "email"] }),
        tokens,
      },
    };
  };
}

module.exports = AuthenService;
