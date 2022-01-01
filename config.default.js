const env = process.env;

const config = {
  db: { 
    host: env.DB_HOST || '10.10.10.10',
    user: env.DB_USER || 'root',
    password: env.DB_PASSWORD || 'password',
    database: env.DB_NAME || 'inventory',
  },
  listPerPage: env.LIST_PER_PAGE || 10,
  password: 'password'
};

module.exports = config;
