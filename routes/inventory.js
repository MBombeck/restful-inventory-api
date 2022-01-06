const express = require('express');
const log4js = require('log4js');
// const config = require('../config/config');

const logger = log4js.getLogger();

const router = express.Router();
const pc = require('../services/inventoryService.js');

/* GET complete inventory from database. */
/* use '/v1/inventory?page=2' to browse */
router.get('/', async (req, res, next) => {
  try {
    res.json(await pc.getMultiple(req.query.page));
  } catch (err) {
    logger.error(`Error while getting inventory items`, err.message);
    next(err);
  }
});

// GET single item
router.get('/:hostname', async (req, res, next) => {
  try {
    res.json(await pc.getSingleItem(req.params.hostname));
  } catch (err) {
    logger.error(`Error while getting inventory item`, err.message);
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
router.delete('/:id', async (req, res, next) => {
  try {
    res.json(await pc.remove(req.params.id));
  } catch (err) {
    logger.error(`Error while deleting inventory item`, err.message);
    next(err);
  }
});

module.exports = router;
