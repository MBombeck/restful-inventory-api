# RESTful Inventory API

A simple Node.js and Express based REST API for managing a computer inventory using a MySQL backend. The service exposes CRUD endpoints protected by HTTP basic authentication and responds with JSON.

## Prerequisites

- [Node.js](https://nodejs.org/) v14 or newer
- [MySQL](https://www.mysql.com/) database

## Installation

```bash
npm install
```

## Configuration

Configuration values can be supplied via environment variables or by editing `config/index.js`.

| Variable | Description | Default |
|---------|-------------|---------|
| `DB_HOST` | MySQL host | `10.10.10.10` |
| `DB_USER` | MySQL user | `root` |
| `DB_PASSWORD` | MySQL password | `password` |
| `DB_NAME` | Database name | `inventory` |
| `LIST_PER_PAGE` | Pagination size | `10` |
| `AUTH_USER` | Basic auth username | `test` |
| `AUTH_PW` | Basic auth password | `test` |
| `PORT` | Server port | `3000` |

Initialise the database using the SQL script in `setup/db_setup.sql`.

## Running the server

```bash
npm start
```

The API will be available at `http://localhost:3000` by default.

## API

All endpoints require HTTP basic authentication.

### `GET /v1/inventory`
Return a paginated list of inventory items.

Query parameters:
- `page` (optional) – page number starting at 1.

### `GET /v1/inventory/:hostname`
Retrieve a single inventory item by hostname.

### `POST /v1/inventory`
Create a new inventory item. Example body:

```json
{
  "hostname": "PC-01",
  "uuid": "deff0438-0776-4e75-b36d-da6eb2c0946e",
  "ip": "10.0.0.5",
  "os": "Windows 11",
  "version": "11.2022",
  "uptime": "42"
}
```

### `PUT /v1/inventory/:hostname`
Update an existing inventory item.

### `DELETE /v1/inventory/:hostname`
Delete an inventory item.

## License

This project is licensed under the MIT License - see [LICENSE.md](LICENSE.md) for details.

## Author

Marc-André Bombeck – [@MBombeck](https://twitter.com/MBombeck)
