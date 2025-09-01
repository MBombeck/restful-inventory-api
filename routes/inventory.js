const express = require('express');
const log4js = require('log4js');

const logger = log4js.getLogger();

const router = express.Router();
const pc = require('../services/inventoryService.js');

/* GET complete inventory sorted by id. */
router.get('/', async (req, res, next) => {
  try {
    res.json(await pc.getAll());
  } catch (err) {
    logger.error(`Error while getting inventory items`, err.message);
    next(err);
  }
});

// GET hostnames sorted by latest update
router.get('/hostnames', async (req, res, next) => {
  try {
    res.json(await pc.getHostnames());
  } catch (err) {
    logger.error(`Error while getting hostnames`, err.message);
    next(err);
  }
});

// GET single item by hostname
router.get('/hostname/:hostname', async (req, res, next) => {
  try {
    res.json(await pc.getByHostname(req.params.hostname));
  } catch (err) {
    logger.error(`Error while getting inventory item by hostname`, err.message);
    next(err);
  }
});

// GET single item by id
router.get('/:id(\\d+)', async (req, res, next) => {
  try {
    res.json(await pc.getById(req.params.id));
  } catch (err) {
    logger.error(`Error while getting inventory item by id`, err.message);
    next(err);
  }
});

// POST
router.post('/', async (req, res, next) => {
  try {
    res.json(await pc.create(req.body));
  } catch (err) {
    logger.error(`Error while creating inventory item`, err.message);
    next(err);
  }
});

// PUT
router.put('/:hostname', async (req, res, next) => {
  try {
    res.json(await pc.update(req.params.hostname, req.body));
  } catch (err) {
    logger.error(`Error while updating inventory item`, err.message);
    next(err);
  }
});

// DELETE
router.delete('/:hostname', async (req, res, next) => {
  try {
    res.json(await pc.remove(req.params.hostname));
  } catch (err) {
    logger.error(`Error while deleting inventory item`, err.message);
    next(err);
  }
});

module.exports = router;
