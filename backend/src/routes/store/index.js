const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const StoreController = require("../../controllers/store.controller");
const { authentication } = require("../../auth/authUtils");

const router = express.Router();
router.route("/").get(asyncHandler(StoreController.findAllStores));
router.route("/:id").get(asyncHandler(StoreController.findStore));
router.use(authentication);
router.route("/").post(asyncHandler(StoreController.createStore));
module.exports = router;
