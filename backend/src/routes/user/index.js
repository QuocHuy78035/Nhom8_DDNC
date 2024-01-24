const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const UserController = require("../../controllers/user.controller");
const { authentication } = require("../../auth/authUtils");

const router = express.Router();
router.use(authentication);
router
  .route("/addToFavorite")
  .post(asyncHandler(UserController.addFoodToFavorite));
router.route("/favorite").get(asyncHandler(UserController.getFavoriteFoods));
router
  .route("/favorite/:food")
  .delete(asyncHandler(UserController.deleteFavoriteFood));
module.exports = router;
