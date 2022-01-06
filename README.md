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
// GET /v1/inventory/
http://localhost:3000/v1/inventory/
```
```
// returns the complete inventory
{
   "data":[
      {
         "id":12,
         "hostname":"L11PAVA-99009",
         "uuid":"p29smmemembnsd929299",
         "ip":"10.10.10.10",
         "os":"Windows 11",
         "version":"11.2022",
         "uptime":"42",
         "created_at":"2021-12-31T19:45:22.000Z"
      },
      ...
}   
```
### Get single inventory item
```
// GET /v1/inventory/$hostname
http://localhost:3000/v1/inventory/L11TEST9900051
```
```
{
   "data":[
      {
         "id":36,
         "hostname":"L11TEST9900051",
         "uuid":"FMD62L6VDOALA612GVD",
         "ip":"10.0.1.10",
         "os":"Windows 11",
         "version":"1999",
         "uptime":"2",
         "updated_at":"2022-01-06T16:39:50.000Z"
      }
   ]
}
```

### Create a new inventory entry
```
// POST /v1/inventory/
http://localhost:3000/v1/inventory/
```
|  Field 	|  Description 	|
|---	|---	|
|  Hostname 	|   Systemname	|
|  uuid 	|   Hardware unique ID 	|
|  IP 	|   local IP	|
|  OS 	|   OS-Name	|
|  Version 	|   OS-Version	|
|  Uptime 	|   current uptime	|
```
// return msg
{
    "message": "Inventory item created successfully"
}
```

### Update a inventory entry
```
// PUT /inventory/$HOSTNAME
http://localhost:3000/v1/inventory/L11TEST9900051
```
|  Field 	|  Description 	|
|---	|---	|
|  uuid 	|   Hardware unique ID 	|
|  IP 	|   local IP	|
|  OS 	|   OS-Name	|
|  Version 	|   OS-Version	|
|  Uptime 	|   current uptime	|
```
// return msg
{
    "message": "Inventory item updated successfully"
}
```

### Delete a inventory entry
```
// DELETE /inventory/$HOSTNAME
http://localhost:3000/v1/inventory/L11TEST9900051
```

```
// return msg
{
    "message": "Inventory item deleted successfully"
}
```

## Authors

Contributors names and contact info

Marc-André Bombeck
[@MBombeck](https://twitter.com/MBombeck)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
