const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const CommentController = require("../../controllers/comment.controller");
const { authentication, restrictTo } = require("../../auth/authUtils");

const router = express.Router();

router.route("/").get(asyncHandler(CommentController.getAllComments));
router.use(authentication);
router
  .route("/")
  .post(restrictTo("user"), asyncHandler(CommentController.createComment));
router
  .route("/:id")
  .delete(restrictTo("user"), asyncHandler(CommentController.removeComment));
router
  .route("/:comment/like")
  .patch(restrictTo("user"), asyncHandler(CommentController.likeComment));
router
  .route("/:comment/unlike")
  .patch(restrictTo("user"), asyncHandler(CommentController.unlikeComment));
router
  .route("/:comment/checkUserLiked")
  .get(restrictTo("user"), asyncHandler(CommentController.checkUserLiked));
module.exports = router;
