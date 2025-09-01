const express = require('express');
const cors = require('cors');
const basicAuth = require('express-basic-auth');
const log4js = require('log4js');

const config = require('./config');

// Logger configuration with optional debug mode and file output
log4js.configure({
  appenders: {
    out: { type: 'stdout' },
    app: { type: 'file', filename: 'app.log' },
  },
  categories: {
    default: { appenders: ['out', 'app'], level: config.debug ? 'debug' : 'info' },
  },
});

const logger = log4js.getLogger();
if (config.debug) {
  logger.debug('Debug mode active');
}

const pcRouter = require('./routes/inventory');

const app = express();

// Basic Auth handler middleware
app.use(
  basicAuth({
    users: { [config.user]: config.password },
    challenge: true, // <--- needed to actually show the login dialog!
  })
);

// Enable CORS
app.use(cors());

// Body parsing
app.use(express.json());
app.use(
  express.urlencoded({
    extended: true,
  })
);

// HTTP request logging
app.use(
  log4js.connectLogger(logger, {
    level: config.debug ? 'debug' : 'info',
    format: (req, res, format) =>
      format(`:remote-addr :method :url ${JSON.stringify(req.body)}`),
  })
);

// Health check route
app.get('/', (req, res) => {
  res.json({ message: 'ok' });
});

// API routes
app.use('/v1/inventory', pcRouter);

// Error handler middleware
app.use((err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  logger.error(err.message, err.stack);
  const message = statusCode === 500 ? 'Internal Server Error' : err.message;
  res.status(statusCode).json({ message });
});

// Start the Server
app.listen(config.port, () => {
  logger.info(`App listening at http://localhost:${config.port}`);
});
