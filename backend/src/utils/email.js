const nodemailer = require("nodemailer");

class Email {
  constructor({ email, resetToken }) {
    this.email = email;
    this.resetToken = resetToken;
  }
  async sendEmail() {
    const transporter = nodemailer.createTransport({
      service: "gmail",
      secure: true,
      auth: {
        user: process.env.AUTH_EMAIL,
        pass: process.env.AUTH_PASS,
      },
    });

    return await transporter.sendMail({
      from: process.env.AUTH_EMAIL, // sender address
      to: this.email, // list of receivers
      subject: "Password Reset ✅", // Subject line
      html: `<p>We heard that you lost the password. </p>
            <p>Don't worry, use the link below to reset it.</p>
            <p>This link <b>expires in 10 minutes</b>. Press
            <a href=${
              "http://localhost:3058/api/v1/resetPassword/" + this.resetToken
            }>here<a/> to proceed.</p>`, // html body
    });
  }
}

module.exports = Email;
