const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = process.env.PORT || 3000;
const basicAuth = require('express-basic-auth');
const pcRouter = require('./routes/pcs');
const config = require('./config');

app.use(
  basicAuth({
    users: { [config.user]: config.password },
    challenge: true, // <--- needed to actually show the login dialog!
  })
);

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

/* Error handler middleware */
app.use((err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  console.error(err.message, err.stack);
  res.status(statusCode).json({ message: err.message });
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
