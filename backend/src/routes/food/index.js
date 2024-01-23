const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const FoodController = require("../../controllers/food.controller");
const { authentication } = require("../../auth/authUtils");

const router = express.Router();

router.route("/").get(asyncHandler(FoodController.findAllFoods));
router.route("/:id").get(asyncHandler(FoodController.findFood));
router.use(authentication);
router.route("/").post(asyncHandler(FoodController.createFood));
module.exports = router;
