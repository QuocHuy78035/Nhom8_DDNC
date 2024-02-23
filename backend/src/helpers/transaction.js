const { startSession } = require("mongoose");

const transaction = async (fn) => {
  const session = await startSession();
  session.startTransaction();

  const result = await fn(session);

  await session.commitTransaction();
  session.endSession();

  return result;
};

module.exports = transaction;
