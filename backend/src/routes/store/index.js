const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const StoreController = require("../../controllers/store.controller");
const { authentication } = require("../../auth/authUtils");
const multer = require("multer");
const upload = multer({ storage: multer.memoryStorage() });
const router = express.Router();
router.route("/").get(asyncHandler(StoreController.findAllStores));
router
  .route("/top10rating")
  .get(asyncHandler(StoreController.findTop10RatingStores));
router.route("/:id").get(asyncHandler(StoreController.findStore));
router.use(authentication);
router
  .route("/")
  .post(upload.single("image"), asyncHandler(StoreController.createStore));
module.exports = router;
