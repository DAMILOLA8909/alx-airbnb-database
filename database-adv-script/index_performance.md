# ⚙️ SQL Indexing and Query Performance Analysis

This document explains how indexing improves query performance in the Airbnb database schema.

---

## 🎯 Objective
Enhance query efficiency by identifying high-usage columns, creating indexes, and measuring their impact using `EXPLAIN` and `ANALYZE`.

---

## 🔍 Identified High-Usage Columns

| Table       | Column(s)             | Reason for Indexing |
|--------------|-----------------------|----------------------|
| users        | user_id               | Used in JOINs with bookings |
| bookings     | user_id, property_id  | Frequently used in JOINs and WHERE clauses |
| properties   | property_id, name     | Used in JOINs and ORDER BY operations |

---

## 🧱 Created Indexes

```sql
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_properties_name ON properties(name);
CREATE INDEX idx_bookings_user_property ON bookings(user_id, property_id);
