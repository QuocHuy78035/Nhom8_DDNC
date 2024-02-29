const { BadRequestError } = require("../core/error.response");
const foodModel = require("../models/food.model");
const { createComment, removeComment } = require("../models/repositories/comment.repo");
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
}

module.exports = CommentService;
