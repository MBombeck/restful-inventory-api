const log4js = require('log4js');
const db = require('./SQLService');
const helper = require('./helperService');
const config = require('../config/config');

const logger = log4js.getLogger();

// GET complete inventory
async function getMultiple(page = 1) {
  const offset = helper.getOffset(page, config.listPerPage);
  const rows = await db.query(
    `SELECT id, hostname, uuid, ip, os, version, uptime, updated_at
    FROM inventory ORDER BY updated_at DESC LIMIT ?,?`,
    [offset, config.listPerPage]
  );
  const data = helper.emptyOrRows(rows);
  const meta = { page };

  return {
    data,
    meta,
  };
}

async function getSingleItem(hostname) {
  const rows = await db.query(
    `SELECT id, hostname, uuid, ip, os, version, uptime, updated_at, cpuname, cpuload, ram, freemem, logonserver, loginuser, vendor, hardwarename, biosfirmwaretype, hdd, hddsize, hddfree, externalip, gatewaym, dnsserver
    FROM inventory WHERE hostname=?`,
    [hostname]
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  };
}

// POST a new PC
async function create(pc) {
  const result = await db.query(
    `INSERT INTO inventory 
    (hostname, uuid, ip, os, version, uptime, cpuname, cpuload, ram, freemem, logonserver, loginuser, vendor, hardwarename, biosfirmwaretype, hdd, hddsize, hddfree, externalip, gateway, dnsserver) 
    VALUES 
    (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,)`,
    [pc.hostname, pc.uuid, pc.ip, pc.os, pc.version, pc.uptime, pc.cpuname, pc.cpuload, pc.ram, pc.freemem, pc.logonserver, pc.loginuser, pc.vendor, pc.hardwarename, pc.biosfirmwaretype, pc.hdd, pc.hddsize, pc.hddfree, pc.externalip, pc.gateway, pc.dnsserver]
  );

  let message = 'Error in creating pc';

  if (result.affectedRows) {
    message = 'Inventory item created successfully';
    logger.info('New inventory item created:', pc.hostname);
  }

  return { message };
}

// Update inventory item via PUT-Request
async function update(hostname, pc) {
  const result = await db.query(
    `UPDATE inventory 
    SET uuid=?, ip=?, 
    os=?, version=?, uptime=?,
    cpuname=?, cpuload=?,
    ram=?, freemem=?, logonserver=?,
    loginuser=?, vendor=?, hardwarename=?,
    biosfirmwaretype=?, hdd=?,
    hddsize=?, hddfree=?,
    externalip=?, gateway=?,
    dnsserver=?,
    WHERE hostname=?`,
    [pc.uuid, pc.ip, pc.os, pc.version, pc.uptime, pc.cpuname, pc.cpuload, pc.ram, pc.freemem, pc.logonserver, pc.loginuser, pc.vendor, pc.hardwarename, pc.biosfirmwaretype, pc.hdd, pc.hddsize, pc.hddfree, pc.externalip, pc.gateway, pc.dnsserver, hostname]
  );

  let message = 'Error in updating pc';

  if (result.affectedRows) {
    message = 'Inventory item updated successfully';
    logger.info('Inventory item updated:', hostname);
  }

  return { message };
}

// DELETE inventory item
async function remove(hostname) {
  const result = await db.query(`DELETE FROM inventory WHERE hostname=?`, [
    hostname,
  ]);

  let message = 'Error in deleting PC';

  if (result.affectedRows) {
    message = 'Inventory item deleted successfully';
    logger.info('Inventory item deleted:', hostname);
  }

  return { message };
}

module.exports = {
  getMultiple,
  getSingleItem,
  create,
  update,
  remove,
};
