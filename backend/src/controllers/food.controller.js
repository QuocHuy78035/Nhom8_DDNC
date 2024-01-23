const { isNull } = require("lodash");
const { OK, CREATED } = require("../core/success.response");
const FoodService = require("../services/food.service");
const { convertToObjectId } = require("../utils");

class FoodController {
  findAllFoods = async (req, res, next) => {
    const result = await FoodService.findAllFoods(req.query);
    return new OK({
      message: "Find all foods successfully!",
      metadata: result,
    }).send(res);
  };

  findFood = async (req, res, next) => {
    const result = await FoodService.findFood(req.params.id);
    return new OK({
      message: "Find food successfully!",
      metadata: result,
    }).send(res);
  };

  createFood = async (req, res, next) => {
    const result = await FoodService.createFood(req.body);
    return new CREATED({
      message: "Create food successfully!",
      metadata: result,
    }).send(res);
  };
}

module.exports = new FoodController();
