const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const CommentController = require("../../controllers/comment.controller");
const { authentication } = require("../../auth/authUtils");

const router = express.Router();

router.route("/").get(asyncHandler(CommentController.getAllComments));
router.use(authentication);
router.route("/").post(asyncHandler(CommentController.createComment));
router.route("/:id").delete(asyncHandler(CommentController.removeComment));
router
  .route("/:comment/like")
  .patch(asyncHandler(CommentController.likeComment));
router
  .route("/:comment/unlike")
  .patch(asyncHandler(CommentController.unlikeComment));
router
  .route("/:comment/checkUserLiked")
  .get(asyncHandler(CommentController.checkUserLiked));
module.exports = router;
