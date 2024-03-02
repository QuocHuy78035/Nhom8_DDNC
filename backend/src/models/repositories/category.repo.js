const { getSelectData, getUnselectData } = require("../../utils");
const UploadFiles = require("../../utils/uploadFile");
const categoryModel = require("../category.model");

const createCategory = async ({ name }, file) => {
  const image = await new UploadFiles(
    "categories",
    "image",
    file
  ).uploadFileAndDownloadURL();
  return await categoryModel.create({ name, image });
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
