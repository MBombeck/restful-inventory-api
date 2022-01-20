const express = require('express');
const bodyParser = require('body-parser');
const basicAuth = require('express-basic-auth');
const log4js = require('log4js');

const logger = log4js.getLogger();
logger.level = 'debug';
logger.debug(`Debug mode active`);

const app = express();
const cors = require('cors');
const pcRouter = require('./routes/inventory');
const config = require('./config/config');

// Basic Auth handler middleware
app.use(
  basicAuth({
    users: { [config.user]: config.password },
    challenge: true, // <--- needed to actually show the login dialog!
  })
);

// Use http logger
app.use(
  log4js.connectLogger(logger, {
    level: 'debug',
    format: (req, res, format) =>
      format(`:remote-addr :method :url ${JSON.stringify(req.body)}`),
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

// OK-Route
app.get('/', (req, res) => {
  res.json({ message: 'ok' });
});

app.use('/v1/inventory', pcRouter);

// Error handler middleware
app.use((err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  logger.error(err.message, err.stack);
  res.status(statusCode).json({ message: err.message });
});

// Start the Server
app.listen(config.port, () => {
  logger.info(`App listening at http://localhost:${config.port}`);
});
