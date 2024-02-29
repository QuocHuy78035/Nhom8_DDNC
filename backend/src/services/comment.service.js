const { BadRequestError } = require("../core/error.response");
const commentModel = require("../models/comment.model");
const foodModel = require("../models/food.model");
const {
  createComment,
  removeComment,
  getAllComments,
} = require("../models/repositories/comment.repo");
const storeModel = require("../models/store.model");
const userModel = require("../models/user.model");
class CommentService {
  static async createComment({ userId, storeId, foodId, comment, rating }) {
    const user = await userModel.findById(userId);
    if (!user) {
      throw new BadRequestError("You are not logged in!");
    }

    const store = await storeModel.findById(storeId);
    if (!store) {
      throw new BadRequestError(`Store with ${storeId} is not found!`);
    }

    const food = await foodModel.findById(foodId);
    if (!food) {
      throw new BadRequestError(`Store with ${foodId} is not found!`);
    }

    const existedComment = await commentModel.findOne({ user: userId, food: foodId });
    if (existedComment) {
      throw new BadRequestError("You have already commented this food!");
    }

    const newComment = await createComment({
      userId,
      storeId,
      foodId,
      comment,
      rating,
    });

    return newComment;
  }

  static async removeComment(id) {
    await removeComment(id);
    return;
  }

  static async getAllComments({ foodId, filter, select, sort }) {
    const food = await foodModel.findById(foodId);
    if (!food) {
      throw new BadRequestError(`Food with id ${food} is not found!`);
    }

    return await getAllComments({ foodId, filter, select, sort });
  }
}

module.exports = CommentService;
