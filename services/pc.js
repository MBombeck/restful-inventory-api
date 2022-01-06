const log4js = require('log4js');
const db = require('./db');
const helper = require('../helper');
const config = require('../config/config');

const logger = log4js.getLogger();

// GET all PCs
async function getMultiple(page = 1) {
  const offset = helper.getOffset(page, config.listPerPage);
  const rows = await db.query(
    `SELECT id, hostname, huid, ip, os, version, uptime, created_at
    FROM inventory ORDER BY created_at DESC LIMIT ?,?`,
    [offset, config.listPerPage]
  );
  const data = helper.emptyOrRows(rows);
  const meta = { page };

  return {
    data,
    meta,
  };
}

module.exports = {
  getMultiple,
};
// POST a new PC
async function create(pc) {
  const result = await db.query(
    `INSERT INTO inventory 
    (hostname, huid, ip, os, version, uptime) 
    VALUES 
    (?, ?, ?, ?, ?, ?)`,
    [pc.hostname, pc.huid, pc.ip, pc.os, pc.version, pc.uptime]
  );

  let message = 'Error in creating pc';

  if (result.affectedRows) {
    message = 'pc created successfully';
    logger.info('New inventory item created:', pc.hostname);
  }

  return { message };
}

module.exports = {
  getMultiple,
  create,
};

// PUT
async function update(hostname, pc) {
  const result = await db.query(
    `UPDATE inventory 
    SET huid=?, ip=?, 
    os=?, version=?, uptime=?
    WHERE hostname=?`,
    [pc.huid, pc.ip, pc.os, pc.version, pc.uptime, hostname]
  );

  let message = 'Error in updating pc';

  if (result.affectedRows) {
    message = 'Pc updated successfully';
    logger.info('Inventory item updated:', hostname);
  }

  return { message };
}

module.exports = {
  getMultiple,
  create,
  update,
};

// DELETE
async function remove(id) {
  const result = await db.query(`DELETE FROM inventory WHERE id=?`, [id]);

  let message = 'Error in deleting PC';

  if (result.affectedRows) {
    message = 'Inventory item deleted successfully';
    logger.info('Inventory item deleted:', id);
  }

  return { message };
}

module.exports = {
  getMultiple,
  create,
  update,
  remove,
};
