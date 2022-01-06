# Restful Inventory API

Simple restful api to build a computer inventory

## Getting Started

### Dependencies

* mysql2
* body-parser
* express-basic-auth
* log4js
 
## API-Documentation

### Get the inventory
```
// GET /pcs/
http://localhost:3000/pcs/
```
```
// returns the complete inventory
{
"data": [
{
"id": 12,
"hostname": "L11PAVA-99009",
"huid": "p29smmemembnsd929299",
"ip": "10.10.10.10",
"os": "Windows 11",
"version": "11.2022",
"uptime": "42",
"created_at": "2021-12-31T19:45:22.000Z"
},
...
]
```

### Create a new inventory entry
```
// POST /pcs/
http://localhost:3000/pcs/
```
|  Field 	|  Description 	|
|---	|---	|
|  Hostname 	|   Systemname	|
|  HUID 	|   Hardware unique ID 	|
|  IP 	|   local IP	|
|  OS 	|   OS-Name	|
|  Version 	|   OS-Version	|
|  Uptime 	|   current uptime	|
```
// return msg
{
    "message": "inventory item created successfully"
}
```

### Update a inventory entry
```
// PUT /pcs/$HOSTNAME
http://localhost:3000/pcs/L11TEST00211
```
|  Field 	|  Description 	|
|---	|---	|
|  HUID 	|   Hardware unique ID 	|
|  IP 	|   local IP	|
|  OS 	|   OS-Name	|
|  Version 	|   OS-Version	|
|  Uptime 	|   current uptime	|
```
// return msg
{
    "message": "inventory item updated successfully"
}
```

### Delete a inventory entry
```
// DELETE /pcs/$HOSTNAME
http://localhost:3000/pcs/1
```

```
// return msg
{
    "message": "inventory item deleted successfully"
}
```

## Authors

Contributors names and contact info

Marc-André Bombeck
[@MBombeck](https://twitter.com/MBombeck)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
