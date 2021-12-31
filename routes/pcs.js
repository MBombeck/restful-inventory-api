const express = require('express');
const router = express.Router();
const pc = require('../services/pc.js');

<<<<<<< HEAD
/* GET */
=======
/* GET all PC's from database. */
/* use '/pcs?page=2' to browse */
>>>>>>> ed47eeff55b64beaa8a13e4e96110018f1775b03
router.get('/', async function(req, res, next) {
  try {
    res.json(await pc.getMultiple(req.query.page));
  } catch (err) {
    console.error(`Error while getting PCs `, err.message);
    next(err);
  }
});

module.exports = router;

<<<<<<< HEAD
/* POST */
=======
/* POST a new PC to inventory */
>>>>>>> ed47eeff55b64beaa8a13e4e96110018f1775b03
router.post('/', async function(req, res, next) {
    try {
      res.json(await pc.create(req.body));
    } catch (err) {
      console.error(`Error while creating pc`, err.message);
      next(err);
    }
  });
  
  module.exports = router;
<<<<<<< HEAD

/* PUT */
router.put('/:hostname', async function(req, res, next) {
    try {
      res.json(await pc.update(req.params.hostname, req.body));
    } catch (err) {
      console.error(`Error while updating pc`, err.message);
      next(err);
    }
  });
=======
>>>>>>> ed47eeff55b64beaa8a13e4e96110018f1775b03
