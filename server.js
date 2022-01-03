const express = require('express');
const bodyParser = require('body-parser');
const basicAuth = require('express-basic-auth');
const log4js = require('log4js');

const logger = log4js.getLogger();
logger.level = 'debug';
logger.debug(`Debugging mode active`);

const app = express();
const cors = require('cors');
const pcRouter = require('./routes/pcs');
const config = require('./config/config');

// Basic Auth handler middleware
app.use(
  basicAuth({
    users: { [config.user]: config.password },
    challenge: true, // <--- needed to actually show the login dialog!
  })
);

// Use CORS
app.use(cors());

app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.get('/', (req, res) => {
  res.json({ message: 'ok' });
});

app.use('/pcs', pcRouter);

// Error handler middleware
app.use((err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  console.error(err.message, err.stack);
  res.status(statusCode).json({ message: err.message });
});

app.listen(config.port, () => {
  logger.info(`App listening at http://localhost:${config.port}`);
});
