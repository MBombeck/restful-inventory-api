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
    // use text protocol to allow LIMIT placeholders and client-side parameter substitution
    const [results] = await pool.query(sql, params);
    return results;
  } catch (err) {
    logger.error('Database query error', err);
    // Map known database errors to user-friendly messages
    if (err.code === 'ER_BAD_FIELD_ERROR') {
      const error = new Error('Invalid column name in query');
      error.statusCode = 400;
      throw error;
    }
    if (err.code === 'ER_WRONG_ARGUMENTS') {
      const error = new Error('Incorrect number of parameters for SQL query');
      error.statusCode = 400;
      throw error;
    }

    const error = new Error('Database query error');
    error.statusCode = 500;
    throw error;
  }
}

module.exports = {
  query,
};

