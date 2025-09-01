const log4js = require('log4js');
const db = require('./SQLService');
const helper = require('./helperService');

const logger = log4js.getLogger();

const requiredFields = [
  'hostname',
  'uuid',
  'ip',
  'os',
  'version',
  'uptime',
  'cpuname',
  'cpuload',
  'ram',
  'freemem',
  'logonserver',
  'loginuser',
  'vendor',
  'hardwarename',
  'biosfirmwaretype',
  'hdd',
  'hddsize',
  'hddfree',
  'externalip',
  'gateway',
  'dnsserver',
];

function validatePc(pc) {
  const missing = requiredFields.filter((field) => pc[field] === undefined);
  if (missing.length) {
    const error = new Error(`Missing required fields: ${missing.join(', ')}`);
    error.statusCode = 400;
    throw error;
  }
}

// GET complete inventory
async function getAll() {
  const rows = await db.query(
    `SELECT * FROM inventory ORDER BY id ASC`
  );
  const data = helper.emptyOrRows(rows);
  return { data };
}

// GET single item by id
async function getById(id) {
  const rows = await db.query(
    `SELECT * FROM inventory WHERE id=?`,
    [id]
  );
  const data = helper.emptyOrRows(rows);
  return { data };
}

// GET single item by hostname
async function getByHostname(hostname) {
  const rows = await db.query(
    `SELECT * FROM inventory WHERE hostname=?`,
    [hostname]
  );
  const data = helper.emptyOrRows(rows);
  return { data };
}

// GET hostnames sorted by latest update
async function getHostnames() {
  const rows = await db.query(
    `SELECT hostname, id, updated_at, ip, externalip, uptime FROM inventory ORDER BY updated_at DESC`
  );
  const data = helper.emptyOrRows(rows);
  return { data };
}

// POST a new PC
async function create(pc) {
  validatePc(pc);
  const result = await db.query(
    `INSERT INTO inventory
    (hostname, uuid, ip, os, version, uptime, cpuname, cpuload, ram, freemem, logonserver, loginuser, vendor, hardwarename, biosfirmwaretype, hdd, hddsize, hddfree, externalip, gateway, dnsserver)
    VALUES
    (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
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
  validatePc(pc);
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
    dnsserver=?
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
  getAll,
  getById,
  getByHostname,
  getHostnames,
  create,
  update,
  remove,
};
