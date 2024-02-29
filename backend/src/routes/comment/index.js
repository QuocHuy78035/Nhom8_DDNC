const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const CommentController = require("../../controllers/comment.controller");
const { authentication } = require("../../auth/authUtils");

const router = express.Router();

router.route("/").get(asyncHandler(CommentController.getAllComments));
router.use(authentication);
router.route("/").post(asyncHandler(CommentController.createComment));
router.route("/:id").delete(asyncHandler(CommentController.removeComment));
module.exports = router;
