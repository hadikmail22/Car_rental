# Car Rental Management System - Database Schema

## 1. User

| Attribute | Type | Key / Constraint |
|---|---|---|
| id | BIGINT | Primary Key |
| username | VARCHAR | Unique, Not Null |
| password | VARCHAR | Not Null |
| full_name | VARCHAR | Not Null |
| phone | VARCHAR | Nullable |
| date_of_birth | DATE | Nullable |
| driving_license_number | VARCHAR | Unique, Nullable |
| enabled | BOOLEAN | Not Null |
| account_expired | BOOLEAN | Not Null |
| account_locked | BOOLEAN | Not Null |
| password_expired | BOOLEAN | Not Null |

## 2. Role

| Attribute | Type | Key / Constraint |
|---|---|---|
| id | BIGINT | Primary Key |
| authority | VARCHAR | Unique, Not Null |

## 3. UserRole

| Attribute | Type | Key / Constraint |
|---|---|---|
| user_id | BIGINT | Primary Key, Foreign Key → User.id |
| role_id | BIGINT | Primary Key, Foreign Key → Role.id |

## 4. Car

| Attribute | Type | Key / Constraint |
|---|---|---|
| id | BIGINT | Primary Key |
| brand | VARCHAR | Not Null |
| model | VARCHAR | Not Null |
| year | INTEGER | Not Null |
| plate_number | VARCHAR | Unique, Not Null |
| price_per_day | DECIMAL | Not Null |
| status | VARCHAR | Not Null |

Car status values:

- AVAILABLE
- RENTED
- MAINTENANCE

## 5. Rental

| Attribute | Type | Key / Constraint |
|---|---|---|
| id | BIGINT | Primary Key |
| customer_id | BIGINT | Foreign Key → User.id |
| car_id | BIGINT | Foreign Key → Car.id |
| start_date | DATE/DATETIME | Not Null |
| end_date | DATE/DATETIME | Not Null |
| total_price | DECIMAL | Not Null |
| booking_deposit | DECIMAL | Not Null |
| deposit_paid | BOOLEAN | Not Null |
| security_deposit | DECIMAL | Not Null |
| damage_cost | DECIMAL | Not Null |
| status | VARCHAR | Not Null |

Rental status values:

- PENDING
- CONFIRMED
- PICKED_UP
- COMPLETED
- CANCELLED

## Relationships

- One User can have many Rentals.
- One Car can have many Rentals.
- Each Rental belongs to one User and one Car.
- Users and Roles are connected through UserRole.