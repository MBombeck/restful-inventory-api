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
``` json
{
   "data":[
      {
         "id":10,
         "hostname":"L11TEST9900051",
         "uuid":"deff0438-0776-4e75-b36d-da6eb2c0946e",
         "ip":"10.10.10.10",
         "os":"Windows 11",
         "version":"11.2022",
         "uptime":"42",
         "created_at":"2021-12-31T19:45:22.000Z"
      },
      {
         "id":11,
         "hostname":"L11TEST9900052",
         "uuid":"5b77cf72-21e3-4c99-aefd-28c01aaca516",
         "ip":"192.168.0.211",
         "os":"Windows 11",
         "version":"10.0.2022",
         "uptime":"42",
         "created_at":"2021-11-12T11:15:02.000Z"
      },
      ]
   }
```
### Get single inventory item
```
// GET /v1/inventory/$hostname
http://localhost:3000/v1/inventory/L11TEST9900051
```
``` json
{
   "data":[
      {
         "id":36,
         "hostname":"L11TEST9900051",
         "uuid":"deff0438-0776-4e75-b36d-da6eb2c0946e",
         "ip":"10.0.1.10",
         "os":"Windows 11",
         "version":"1999",
         "uptime":"2",
         "updated_at":"2022-01-06T16:39:50.000Z"
      }
   ]
}
```

### Create a new inventory item
```
// POST /v1/inventory/
http://localhost:3000/v1/inventory/
```
|  Field 	|  Description 	|  Required 	|
|---	|---	|---	|
|  Hostname 	|   Systemname	| X |
|  uuid 	|   Hardware unique ID 	| |
|  IP 	|   local IP	| |
|  OS 	|   OS-Name	||
|  Version 	|   OS-Version	||
|  Uptime 	|   current uptime	||
``` json
{
    "message": "Inventory item created successfully"
}
```

### Update a inventory item
```
// PUT /inventory/$HOSTNAME
http://localhost:3000/v1/inventory/L11TEST9900051
```
|  Field 	|  Description 	|  Required 	|
|---	|---	| ---	|
|  uuid 	|   Hardware unique ID 	||
|  IP 	|   local IP	||
|  OS 	|   OS-Name	||
|  Version 	|   OS-Version	||
|  Uptime 	|   current uptime	||
``` json
{
    "message": "Inventory item updated successfully"
}
```

### Delete a inventory item
```
// DELETE /inventory/$HOSTNAME
http://localhost:3000/v1/inventory/L11TEST9900051
```

``` json
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
