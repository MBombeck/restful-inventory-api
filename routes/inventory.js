const express = require('express');

const router = express.Router();
const pc = require('../services/requestService.js');

/* GET all PC's from database. */
/* use '/v1/inventory?page=2' to browse */
router.get('/', async (req, res, next) => {
  try {
    res.json(await pc.getMultiple(req.query.page));
  } catch (err) {
    console.error(`Error while getting inventory items `, err.message);
    next(err);
  }
});

module.exports = router;

// POST
router.post('/', async (req, res, next) => {
  try {
    res.json(await pc.create(req.body));
  } catch (err) {
    console.error(`Error while creating inventory item`, err.message);
    next(err);
  }
});

module.exports = router;

// PUT
router.put('/:hostname', async (req, res, next) => {
  try {
    res.json(await pc.update(req.params.hostname, req.body));
  } catch (err) {
    console.error(`Error while updating inventory item`, err.message);
    next(err);
  }
});

// DELETE
router.delete('/:id', async (req, res, next) => {
  try {
    res.json(await pc.remove(req.params.id));
  } catch (err) {
    console.error(`Error while deleting inventory item`, err.message);
    next(err);
  }
});
