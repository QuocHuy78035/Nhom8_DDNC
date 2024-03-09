const express = require("express");
const { asyncHandler } = require("../../helpers/asyncHandler");
const OrderController = require("../../controllers/order.controller");
const { authentication, restrictTo } = require("../../auth/authUtils");

const router = express.Router();

router.use(authentication);
router
  .route("/")
  .post(restrictTo("user"), asyncHandler(OrderController.createOrder));
router
  .route("/")
  .get(restrictTo("vendor"), asyncHandler(OrderController.findAllOrders));
router
  .route("/:id")
  .patch(
    restrictTo("user", "vendor"),
    asyncHandler(OrderController.updateStatusOrders)
  );

module.exports = router;
