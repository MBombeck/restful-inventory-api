const mysql = require('mysql2/promise');
const config = require('../config/config');
const log4js = require('log4js');

async function query(sql, params) {
  const connection = await mysql.createConnection(config.db);
  try {
    const [results] = await connection.execute(sql, params);
    connection.end();
    return results;
  } catch (err) {
    connection.end();
    //logger.error(err); 
   } 
}

module.exports = {
  query,
};

