const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const { authentication } = require("../../auth/authUtils");
const CartController = require("../../controllers/cart.controller");

const router = express.Router();
router.use(authentication);
router.route("/").get(asyncHandler(CartController.getCart));
router.route("/").post(asyncHandler(CartController.addToCart));
router.route("/:mode").patch(asyncHandler(CartController.updateNumberCart));
module.exports = router;
