const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const UserController = require("../../controllers/user.controller");
const { authentication, restrictTo } = require("../../auth/authUtils");

const router = express.Router();
router.use(authentication);
router.use(restrictTo("user"));
router
  .route("/favoriteFood")
  .post(asyncHandler(UserController.addFoodToFavorite));
router
  .route("/favoriteFood")
  .get(asyncHandler(UserController.getFavoriteFoods));
router
  .route("/favoriteFood/:food")
  .delete(asyncHandler(UserController.deleteFavoriteFood));
router
  .route("/favoriteFood/checkIsFavorite/:food")
  .get(asyncHandler(UserController.checkFoodIsFavorite));
router
  .route("/favoriteStore")
  .post(asyncHandler(UserController.addStoreToFavorite));
router
  .route("/favoriteStore")
  .get(asyncHandler(UserController.getFavoriteStores));
router
  .route("/favoriteStore/:store")
  .delete(asyncHandler(UserController.deleteFavoriteStore));
router
  .route("/favoriteStore/checkIsFavorite/:store")
  .get(asyncHandler(UserController.checkStoreIsFavorite));
module.exports = router;
