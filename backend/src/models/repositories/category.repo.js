const { getSelectData, getUnselectData } = require("../../utils");
const categoryModel = require("../category.model");

const createCategory = async (data) => {
  return await categoryModel.create(data);
};
const findCategory = async ({ id, select = [] }) => {
  return await categoryModel.findById(id).select(getSelectData(select));
};
const findAllCategories = async ({ select = [] }) => {
  return await categoryModel.find().select(getSelectData(select));
};

module.exports = {
  createCategory,
  findAllCategories,
  findCategory,
};
