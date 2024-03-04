const { CREATED, OK } = require("../core/success.response");
const StoreService = require("../services/store.service");

class StoreController {
  findAllStores = async (req, res, next) => {
    const { sort, categories, search, coordinate } = req.query;
    const result = await StoreService.findAllStores({
      categories,
      search,
      sort,
      coordinate,
    });
    return new OK({
      message: "Find all stores successfully!",
      metadata: result,
    }).send(res);
  };
  findTop10RatingStores = async (req, res, next) => {
    const result = await StoreService.findTop10RatingStores(
      req.query.coordinate
    );
    return new OK({
      message: "Find top 10 rating stores successfully!",
      metadata: result,
    }).send(res);
  };
  findStore = async (req, res, next) => {
    const result = await StoreService.findStore(
      req.params.id,
      req.query.coordinate
    );
    return new OK({
      message: "Find store successfully!",
      metadata: result,
    }).send(res);
  };
  createStore = async (req, res, next) => {
    const result = await StoreService.createStore(req.body, req.file);
    return new CREATED({
      message: "Create store successfully!",
      metadata: result,
    }).send(res);
  };
}

module.exports = new StoreController();
