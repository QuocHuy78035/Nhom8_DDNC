const _ = require("lodash");
const { Types } = require("mongoose");

const getInfoData = ({ object = {}, fields = [] }) => {
  return _.pick(object, fields);
};
/*
  ['type', 1],
  ['col', 2]
  => {
    type: 1,
    col: 2
  }
*/
const getSelectData = (select = []) => {
  return Object.fromEntries(select.map((e) => [e, 1]));
};
const getUnselectData = (select = []) => {
  return Object.fromEntries(select.map((e) => [e, 0]));
};
const convertToObjectId = (id) => new Types.ObjectId(id);
module.exports = {
  getInfoData,
  getSelectData,
  getUnselectData,
  convertToObjectId,
};
