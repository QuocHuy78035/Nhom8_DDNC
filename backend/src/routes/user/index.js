const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const UserController = require("../../controllers/user.controller");
const { authentication, restrictTo } = require("../../auth/authUtils");

const router = express.Router();
router.use(authentication);
router
  .route("/favoriteFood")
  .post(restrictTo("user"), asyncHandler(UserController.addFoodToFavorite));
router
  .route("/favoriteFood")
  .get(restrictTo("user"), asyncHandler(UserController.getFavoriteFoods));
router
  .route("/favoriteFood/:food")
  .delete(restrictTo("user"), asyncHandler(UserController.deleteFavoriteFood));
router
  .route("/favoriteFood/checkIsFavorite/:food")
  .get(restrictTo("user"), asyncHandler(UserController.checkFoodIsFavorite));
router
  .route("/favoriteStore")
  .post(restrictTo("user"), asyncHandler(UserController.addStoreToFavorite));
router
  .route("/favoriteStore")
  .get(restrictTo("user"), asyncHandler(UserController.getFavoriteStores));
router
  .route("/favoriteStore/:store")
  .delete(restrictTo("user"), asyncHandler(UserController.deleteFavoriteStore));
router
  .route("/favoriteStore/checkIsFavorite/:store")
  .get(restrictTo("user"), asyncHandler(UserController.checkStoreIsFavorite));

router
  .route("/pendingvendors")
  .get(restrictTo("admin"), asyncHandler(UserController.getAllPendingVendors));
router
  .route("/status")
  .post(restrictTo("admin"), asyncHandler(UserController.changeStatusOfUser));
module.exports = router;
