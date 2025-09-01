const mysql = require('mysql2/promise');
const log4js = require('log4js');
const config = require('../config');

const logger = log4js.getLogger();

const pool = mysql.createPool({
  ...config.db,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

async function query(sql, params) {
  try {
    const [results] = await pool.execute(sql, params);
    return results;
  } catch (err) {
    logger.error('Database query error', err);
    throw err;
  }
}

module.exports = {
  query,
};

