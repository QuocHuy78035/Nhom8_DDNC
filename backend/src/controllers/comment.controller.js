const { CREATED, OK } = require("../core/success.response");
const CommentService = require("../services/comment.service");

class CommentController {
  createComment = async (req, res, next) => {
    const { store, food, comment, rating } = req.body;
    const newComment = await CommentService.createComment({
      userId: req.user.userId,
      storeId: store,
      foodId: food,
      comment,
      rating,
    });
    new CREATED({
      message: "Create comment successfully!",
      metadata: {
        comment: newComment,
      },
    }).send(res);
  };

  removeComment = async (req, res, next) => {
    await CommentService.removeComment(req.params.id);
    new OK({
      message: "Remove comment successfully!",
    }).send(res);
  };
}

module.exports = new CommentController();
