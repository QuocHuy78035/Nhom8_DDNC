const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const FoodController = require("../../controllers/food.controller");
const { authentication, restrictTo } = require("../../auth/authUtils");
const multer = require("multer");
const upload = multer({ storage: multer.memoryStorage() });
const router = express.Router();

router.route("/").get(asyncHandler(FoodController.findAllFoods));
router.route("/:id").get(asyncHandler(FoodController.findFood));
router.use(authentication);
router
  .route("/")
  .post(
    restrictTo("admin"),
    upload.single("image"),
    asyncHandler(FoodController.createFood)
  );
module.exports = router;
