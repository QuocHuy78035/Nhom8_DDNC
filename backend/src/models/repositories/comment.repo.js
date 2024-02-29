const { Types } = require("mongoose");
const commentModel = require("../comment.model");
const storeModel = require("../store.model");
const foodModel = require("../food.model");
const { BadRequestError } = require("../../core/error.response");
const transaction = require("../../helpers/transaction");

const updateRating = async ({ foodId, storeId, session }) => {
  const [avgByFood, avgByStore] = await Promise.all([
    commentModel.aggregate([
      {
        $match: { food: new Types.ObjectId(foodId) },
      },
      {
        $group: {
          _id: "$food",
          avgRating: { $avg: "$rating" },
        },
      },
    ]),
    commentModel.aggregate([
      {
        $match: { store: new Types.ObjectId(storeId) },
      },
      {
        $group: {
          _id: "$store",
          avgRating: { $avg: "$rating" },
        },
      },
    ]),
  ]);

  await Promise.all([
    storeModel.findByIdAndUpdate(
      storeId,
      {
        rating: Math.round(avgByStore[0].avgRating * 10) / 10,
      },
      { session }
    ),
    foodModel.findByIdAndUpdate(
      foodId,
      {
        rating: Math.round(avgByFood[0].avgRating * 10) / 10,
      },
      { session }
    ),
  ]);
};

const createComment = async ({ userId, storeId, foodId, comment, rating }) => {
  return await transaction(async (session) => {
    const newComment = await commentModel.create(
      [
        {
          user: userId,
          store: storeId,
          food: foodId,
          comment,
          rating,
        },
      ],
      { session }
    );
    if (!newComment[0]) {
      throw new BadRequestError("Create comment unsuccessfully!");
    }

    await updateRating({ foodId, storeId, session });

    return newComment[0];
  });
};

const removeComment = async (id) => {
  return await transaction(async (session) => {
    const comment = await commentModel.findById(id);
    if (!comment) {
      throw new BadRequestError(`Comment with id ${id} is not found!`);
    }
    await commentModel.findByIdAndDelete(id, { session });

    await updateRating({
      foodId: comment.food,
      storeId: comment.store,
      session,
    });
    return;
  });
};

module.exports = {
  createComment,
  removeComment,
};
