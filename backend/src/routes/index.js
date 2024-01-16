"use strict"

const express = require("express");
const authen = require("./authen");

const router = express.Router();

router.use("/api/v1", authen);

module.exports = router;