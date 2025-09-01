# RESTful Inventory API

The RESTful Inventory API is a small, production-ready service for tracking computers and their attributes. Built with Node.js and Express, it stores data in MySQL and offers a clean REST interface secured with HTTP basic authentication. The project emphasises simplicity and best practices, making it easy to deploy and extend.


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
| `DB_HOST` | MySQL host | `db` |
| `DB_USER` | MySQL user | `root` |
| `DB_PASSWORD` | MySQL password | `password` |
| `DB_NAME` | Database name | `inventory` |
| `AUTH_USER` | Basic auth username | `test` |
| `AUTH_PW` | Basic auth password | `test` |
| `PORT` | Server port | `3000` |
| `DEBUG` | Enable verbose logging | `false` |

Initialise the database using the SQL script in `setup/db_setup.sql`.

## Running the server

```bash
npm start
```

The API will be available at `http://localhost:3000` by default.

## Docker

Run the API and a MySQL instance with a single command:

```bash
docker-compose up --build
```

The MySQL service initialises with `setup/db_setup.sql`. Stop the stack with `Ctrl+C` and remove containers using:

```bash
docker-compose down
```


## API

All endpoints require HTTP basic authentication.

### `GET /v1/inventory`
Return the full inventory sorted by `id`.

```bash
curl -u test:test http://localhost:3000/v1/inventory
```

### `GET /v1/inventory/:id`
Retrieve a single inventory item by numeric `id`.

```bash
curl -u test:test http://localhost:3000/v1/inventory/1
```

### `GET /v1/inventory/hostname/:hostname`
Retrieve a single inventory item by `hostname`.

```bash
curl -u test:test http://localhost:3000/v1/inventory/hostname/PC-01
```

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
