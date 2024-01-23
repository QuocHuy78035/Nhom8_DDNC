const { getSelectData, getUnselectData } = require("../../utils");
const storeModel = require("../store.model");

const findAllStores = async ({ unselect = [] }) => {
  return await storeModel.find().select(getUnselectData(unselect));
};
const findStore = async ({ id, unselect = [] }) => {
  return await storeModel.findById(id).select(getUnselectData(unselect));
};
const createStore = async (data) => {
  return await storeModel.create(data);
};

module.exports = {
  findAllStores,
  findStore,
  createStore,
};
