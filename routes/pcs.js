const express = require('express');
const router = express.Router();
const pc = require('../services/pc.js');

/* GET pc. */
router.get('/', async function(req, res, next) {
  try {
    res.json(await pc.getMultiple(req.query.page));
  } catch (err) {
    console.error(`Error while getting Pcs `, err.message);
    next(err);
  }
});

module.exports = router;

/* POST pc */
router.post('/', async function(req, res, next) {
    try {
      res.json(await pc.create(req.body));
    } catch (err) {
      console.error(`Error while creating pc`, err.message);
      next(err);
    }
  });
  
  module.exports = router;