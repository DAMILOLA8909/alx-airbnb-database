# database-adv-script
ALX

# 🧠 Advanced SQL Joins – Airbnb Database Script

This project demonstrates the use of **different SQL JOIN operations** as part of the **Advanced SQL: Complex Queries, Indexing, and Optimization** module.

It includes:
- Table creation scripts  
- Sample data inserts  
- INNER JOIN, LEFT JOIN, and FULL OUTER JOIN examples  

---

## 🎯 Objective
Master SQL joins by writing complex queries using:
- **INNER JOIN** → Retrieve related records across tables  
- **LEFT JOIN** → Include unmatched records from the left table  
- **FULL OUTER JOIN** → Retrieve all records from both tables  

---

## 🧩 Database Schema

| Table | Description |
|--------|--------------|
| `users` | Stores user information |
| `properties` | Contains property listings |
| `bookings` | Links users to properties through reservations |
| `reviews` | Contains user reviews for properties |

---

## 🧪 Sample Data Preview

### 👤 `users`
| user_id | name           | email              |
|----------|----------------|--------------------|
| 1 | Alice Johnson | alice@example.com |
| 2 | Brian Smith   | brian@example.com |
| 3 | Clara Davis   | clara@example.com |
| 4 | David Wilson  | david@example.com |

### 🏠 `properties`
| property_id | name             | location |
|--------------|------------------|-----------|
| 1 | Seaside Villa   | Lagos  |
| 2 | Mountain Lodge  | Jos    |
| 3 | City Apartment  | Abuja  |
| 4 | Country Cottage | Ibadan |

### 📅 `bookings`
| booking_id | user_id | property_id | booking_date |
|-------------|----------|-------------|---------------|
| 1 | 1 | 1 | 2025-01-15 |
| 2 | 2 | 2 | 2025-02-10 |
| 3 | 3 | 3 | 2025-03-05 |

### 💬 `reviews`
| review_id | property_id | user_id | rating | comment |
|------------|--------------|----------|---------|----------|
| 1 | 1 | 1 | 5 | Amazing stay with a great view! |
| 2 | 2 | 2 | 4 | Cozy and clean. Would visit again. |
| 3 | 3 | 3 | 3 | Nice but noisy neighborhood. |

---

## 🧾 Queries Overview

### 1️⃣ INNER JOIN
**Goal:** Retrieve all bookings and the respective users who made those bookings.

```sql
SELECT 
    users.user_id,
    users.name AS user_name,
    bookings.booking_id,
    bookings.property_id,
    bookings.booking_date
FROM 
    users
INNER JOIN 
    bookings 
ON 
    users.user_id = bookings.user_id;
```

#### 📘 Explanation:
This query only returns records where there is a matching user_id in both users and bookings.

---

### 2️⃣ LEFT JOIN

Goal: Retrieve all properties and their reviews, including properties that have no reviews.

```sql
SELECT 
    properties.property_id,
    properties.name AS property_name,
    reviews.review_id,
    reviews.rating,
    reviews.comment
FROM 
    properties
LEFT JOIN 
    reviews 
ON 
    properties.property_id = reviews.property_id;
```

#### 📘 Explanation:
This query returns all properties, even if they don’t have a review.
If a property has no review, the review_id, rating, and comment will be NULL.

---

### 3️⃣ FULL OUTER JOIN

Goal: Retrieve all users and all bookings, even if a user has no booking or a booking is not linked to a user.

```sql
SELECT 
    users.user_id,
    users.name AS user_name,
    bookings.booking_id,
    bookings.property_id,
    bookings.booking_date
FROM 
    users
LEFT JOIN 
    bookings 
ON 
    users.user_id = bookings.user_id

UNION

SELECT 
    users.user_id,
    users.name AS user_name,
    bookings.booking_id,
    bookings.property_id,
    bookings.booking_date
FROM 
    users
RIGHT JOIN 
    bookings 
ON 
    users.user_id = bookings.user_id;
```

#### 📘 Explanation:
Since MySQL does not support FULL OUTER JOIN, this query uses a combination of LEFT JOIN and RIGHT JOIN with UNION to simulate the same behavior.

---

### ⚙️ How to Run

1. Make sure your MySQL server is running.

2. Create and select your database:
```bash
mysql -u <your_username> -p
CREATE DATABASE airbnb_db;
USE airbnb_db;
```
3. Execute the script::
```bash
mysql -u <your_username> -p airbnb_db < database-adv-script/joins_queries.sql
```

### ✅ Expected Learning Outcomes

By the end of this task, you should be able to:

- Understand and apply INNER, LEFT, and FULL OUTER JOINs

- Retrieve relational data from multiple tables

- Write clean, efficient, and testable SQL join queries

- Analyze how different joins affect result sets

---

---

# 🧠 SQL Subqueries – Airbnb Database Script

This project demonstrates how to use **subqueries** in SQL to retrieve data based on conditions from other queries.  
It includes both **correlated** and **non-correlated** examples.

---

## 🎯 Objective
- Write a query using a non-correlated subquery to find properties with average ratings greater than 4.0  
- Write a correlated subquery to find users who have made more than 3 bookings  

---

## 🧩 Queries Overview

### 1️⃣ Non-Correlated Subquery
**Goal:** Find all properties where the average rating is greater than 4.0  

```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location
FROM 
    properties p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            reviews r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    );
```
#### 📘 Explanation:
The inner query calculates the average rating for each property.
The outer query then selects only those properties whose average rating exceeds 4.0.

### 2️⃣ Correlated Subquery

Goal: Find users who have made more than 3 bookings

```sql
SELECT 
    u.user_id,
    u.name AS user_name,
    u.email
FROM 
    users u
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            bookings b
        WHERE 
            b.user_id = u.user_id
    ) > 3;
```
📘 Explanation:
Here, the inner query is correlated with the outer one because it depends on each specific user (u.user_id).
It counts how many bookings each user has made and returns those with more than 3.

---

### ⚙️ How to Run

In your terminal:
```bash
mysql -u <your_username> -p airbnb_db < database-adv-script/subqueries.sql
```

### ✅ Expected Learning Outcomes

- Understand the difference between correlated and non-correlated subqueries

- Write efficient nested queries for complex data filtering

- Perform aggregate-based filtering using subqueries


---

---

# 📊 SQL Aggregation and Window Functions – Airbnb Database Script

This module demonstrates how to use **aggregation** and **window functions** in SQL  
to analyze user and property booking data effectively.

---

## 🎯 Objective
- Count total bookings made by each user using `COUNT()` and `GROUP BY`
- Use window functions (`RANK()` and `ROW_NUMBER()`) to rank and number properties based on booking volume

---

## 🧮 1️⃣ Aggregation Query
**Goal:** Find total number of bookings made by each user  

```sql
SELECT 
    u.user_id,
    u.name AS user_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    users u
LEFT JOIN 
    bookings b
ON 
    u.user_id = b.user_id
GROUP BY 
    u.user_id, u.name
ORDER BY 
    total_bookings DESC;
```
#### 📘 Explanation:
- Counts all bookings made by each user.
- LEFT JOIN ensures even users with no bookings are included.

---

### 2️⃣ Window Function Query – Using RANK()

Goal: Rank properties by number of bookings
```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS property_rank
FROM 
    properties p
LEFT JOIN 
    bookings b
ON 
    p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name
ORDER BY 
    total_bookings DESC;
```
#### 📘 Explanation:

- RANK() assigns a position based on total bookings.

- If two properties have the same count, they share the same rank.

---

### 3️⃣ Window Function Query – Using ROW_NUMBER()

Goal: Assign unique sequential numbers to each property
```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS property_row_number
FROM 
    properties p
LEFT JOIN 
    bookings b
ON 
    p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name
ORDER BY 
    total_bookings DESC;
```

#### 📘 Explanation:

- ROW_NUMBER() assigns a unique number to each row, even if booking totals tie.

- Ideal for pagination or sequential data analysis.

---

### ⚙️ How to Run

```bash
mysql -u <your_username> -p airbnb_db < database-adv-script/aggregations_and_window_functions.sql
```

---

### 🧪 Sample Data Demonstration

Sample records are provided for `users`, `properties`, and `bookings` so queries can be tested directly.

Run:
```bash
mysql -u <your_username> -p airbnb_db < database-adv-script/aggregations_and_window_functions.sql
```

| user_name     | total_bookings |
| ------------- | -------------- |
| David Brown   | 3              |
| Brian Smith   | 3              |
| Cynthia Lee   | 3              |
| Alice Johnson | 2              |
| Ella Turner   | 1              |

| property_name        | total_bookings | property_rank | property_row_number |
| -------------------- | -------------- | ------------- | ------------------- |
| Ocean View Apartment | 3              | 1             | 1                   |
| City Center Loft     | 3              | 1             | 2                   |
| Beach Villa          | 3              | 1             | 3                   |
| Mountain Cabin       | 2              | 4             | 4                   |
| Country House        | 1              | 5             | 5                   |


### ✅ Expected Learning Outcomes

- Summarize data using COUNT() and GROUP BY

- Analyze datasets using RANK() and ROW_NUMBER()

- Understand how window functions differ from regular aggregations

- Write analytical queries that power reporting dashboards

---

---

## 🧑‍💻 Author

**Damilola Ojo**

Advanced SQL Project — ALX Airbnb Database

---