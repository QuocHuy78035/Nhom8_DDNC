const { CREATED, OK } = require("../core/success.response");
const StoreService = require("../services/store.service");

class StoreController {
  findAllStores = async (req, res, next) => {
    const { sort, categories, search } = req.query;
    const result = await StoreService.findAllStores({
      categories,
      search,
      sort,
    });
    return new OK({
      message: "Find all stores successfully!",
      metadata: result,
    }).send(res);
  };
  findTop10RatingStores = async (req, res, next) => {
    const result = await StoreService.findTop10RatingStores();
    return new OK({
      message: "Find top 10 rating stores successfully!",
      metadata: result,
    }).send(res);
  };
  findStore = async (req, res, next) => {
    console.log(req.params.id);
    const result = await StoreService.findStore(req.params.id);
    return new OK({
      message: "Find store successfully!",
      metadata: result,
    }).send(res);
  };
  createStore = async (req, res, next) => {
    const result = await StoreService.createStore(req.body);
    return new CREATED({
      message: "Create store successfully!",
      metadata: result,
    }).send(res);
  };
}

module.exports = new StoreController();
