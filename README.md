# README

## Abstract

This repository resolves a technical test for Colisweb, a French company for a Ruby on Rails backend senior job.

The objective was to built API will manage Transporter organizations of Colisweb and the Carriers of these transporters.

To complete this test, I was asked to use Ruby on Rails 4.2. 

## Database Schema

![Database schema](https://github.com/alex-lairan/transporters_colisweb/raw/master/images/database.png)

## Routes

| VERB | ROUTE                                                      |
|------|------------------------------------------------------------|
| POST | /transporters                                              |
| GET  | /transporters/:transporter_id/carriers                     |
| PUT  | /carrier/:carrier_id/trackings                             |
| GET  | /transporters/by_postal_codes                              |
| GET  | /carriers/passed_by/:latitude/:longitude                   |
| GET  | /transporters/with_carriers_passed_by/:latitude/:longitude |

### POST /transporters

Description

It create a transporter with it's postal codes and carriers.

Body

```JSON
{
	"name": "String",
	"SIRET": "String",
	"postal_codes": "Array(String)",
	"carriers": "Array(Carrier)"
}
```

Carrier

```JSON
{
    "name": "String",
    "age": "Integer",
    "has_driver_licence_a": "Bool",
    "has_driver_licence_b": "Bool",
    "has_driver_licence_c": "Bool"
}
```

### PUT /carrier/:carrier_id/trackings

Description

Add a location to a carrier

Body

```JSON
{
  "latitude": "Double",
  "longitude": "Double",
  "altitude": "Double"
}
```
