const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const CategoryController = require("../../controllers/category.controller");
const { authentication } = require("../../auth/authUtils");

const router = express.Router();
router.route("/").get(asyncHandler(CategoryController.findAllCategories));
router.route("/:id").get(asyncHandler(CategoryController.findCategory));
router.use(authentication);
router.route("/").post(asyncHandler(CategoryController.createCategory));

module.exports = router;
