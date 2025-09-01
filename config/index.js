const { env } = process;

const config = {
  db: {
    host: env.DB_HOST || '10.10.10.10',
    user: env.DB_USER || 'root',
    password: env.DB_PASSWORD || 'password',
    database: env.DB_NAME || 'inventory',
  },
  listPerPage: parseInt(env.LIST_PER_PAGE, 10) || 10,
  user: env.AUTH_USER || 'test',
  password: env.AUTH_PW || 'test',
  port: parseInt(env.PORT, 10) || 3000,
};

module.exports = config;
