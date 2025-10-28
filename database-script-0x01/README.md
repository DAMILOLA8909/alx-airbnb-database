# AirBnB Database Schema

## Overview
This SQL script defines the relational database schema for the AirBnB system.  
It includes six core entities — **User**, **Property**, **Booking**, **Payment**, **Review**, and **Message** — based on the ER diagram and normalized up to **Third Normal Form (3NF)**.

---

## Schema Design Principles
- **Data Integrity:** Maintained through primary and foreign key constraints.  
- **Normalization:** The database satisfies **1NF**, **2NF**, and **3NF**, ensuring no redundancy or transitive dependency.  
- **Referential Integrity:** Enforced using foreign keys with `ON DELETE CASCADE`.  
- **Performance Optimization:** Key columns like `email`, `property_id`, and `booking_id` are indexed for faster lookups.  

---

## Entity Relationships
| Entity | Relationship | Type |
|---------|--------------|------|
| User → Property | A user (host) can own multiple properties | One-to-Many |
| User → Booking | A user (guest) can make multiple bookings | One-to-Many |
| Property → Booking | A property can be booked many times | One-to-Many |
| Booking → Payment | Each booking can have one or more payments | One-to-Many |
| User → Review | A user can write multiple reviews | One-to-Many |
| Property → Review | A property can have multiple reviews | One-to-Many |
| User → Message | A user can send/receive multiple messages | One-to-Many |

---

## ERD-to-Schema Mapping

| ER Diagram Entity | SQL Table | Primary Key | Key Foreign Relationships | Notes |
|--------------------|------------|--------------|----------------------------|--------|
| **User** | `User` | `user_id` | — | Stores all user information including role (guest, host, admin). |
| **Property** | `Property` | `property_id` | `host_id → User(user_id)` | Each property belongs to a host (User). |
| **Booking** | `Booking` | `booking_id` | `property_id → Property(property_id)`<br>`user_id → User(user_id)` | Links users and properties through reservations. |
| **Payment** | `Payment` | `payment_id` | `booking_id → Booking(booking_id)` | Represents payments made for specific bookings. |
| **Review** | `Review` | `review_id` | `property_id → Property(property_id)`<br>`user_id → User(user_id)` | Allows guests to review properties. |
| **Message** | `Message` | `message_id` | `sender_id → User(user_id)`<br>`recipient_id → User(user_id)` | Stores user-to-user communication data. |

---

## Tables Summary

| Table | Primary Key | Key Foreign Keys | Important Constraints |
|--------|--------------|------------------|------------------------|
| `User` | `user_id` | — | `email` is `UNIQUE`; `role` uses ENUM. |
| `Property` | `property_id` | `host_id → User(user_id)` | Cascading deletes on host removal. |
| `Booking` | `booking_id` | `property_id`, `user_id` | `status` limited to ENUM values (`pending`, `confirmed`, `canceled`). |
| `Payment` | `payment_id` | `booking_id → Booking(booking_id)` | Amount is required, `payment_method` uses ENUM. |
| `Review` | `review_id` | `property_id`, `user_id` | `rating` between 1 and 5 enforced by CHECK. |
| `Message` | `message_id` | `sender_id`, `recipient_id` | Both linked to the User table with cascading deletes. |

---

## Indexing Strategy
To enhance performance, the following indexes are included:
- `idx_user_email` on **User(email)**
- `idx_property_host_id` on **Property(host_id)**
- `idx_booking_property_id` and `idx_booking_user_id` on **Booking**
- `idx_payment_booking_id` on **Payment**
- `idx_review_property_id` and `idx_review_user_id` on **Review**

These indexes ensure efficient query execution on high-frequency lookup fields.

---

## How to Run

### PostgreSQL
```bash
psql -U your_username -d airbnb_db -f schema.sql

### MySQL

mysql -u your_username -p airbnb_db < schema.sql

### License

This project is part of the ALX AirBnB Database Design learning module.
It demonstrates database design, normalization, and SQL schema definition following best industry practices.