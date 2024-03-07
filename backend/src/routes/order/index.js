const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const OrderController = require("../../controllers/order.controller");
const { authentication } = require("../../auth/authUtils");

const router = express.Router();

router.use(authentication);
router.route("/").post(asyncHandler(OrderController.createOrder));
router.route("/").get(asyncHandler(OrderController.findAllOrders));
router.route("/:id").patch(asyncHandler(OrderController.updateStatusOrders));

module.exports = router;
