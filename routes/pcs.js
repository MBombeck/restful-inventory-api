const express = require('express');

const router = express.Router();
const pc = require('../services/pc.js');

/* GET all PC's from database. */
/* use '/pcs?page=2' to browse */
router.get('/', async (req, res, next) => {
  try {
    res.json(await pc.getMultiple(req.query.page));
  } catch (err) {
    console.error(`Error while getting PCs `, err.message);
    next(err);
  }
});

module.exports = router;

/* POST a new PC to inventory */
router.post('/', async (req, res, next) => {
  try {
    res.json(await pc.create(req.body));
  } catch (err) {
    console.error(`Error while creating pc`, err.message);
    next(err);
  }
});

module.exports = router;

/* PUT */
router.put('/:hostname', async (req, res, next) => {
  try {
    res.json(await pc.update(req.params.hostname, req.body));
  } catch (err) {
    console.error(`Error while updating pc`, err.message);
    next(err);
  }
});
