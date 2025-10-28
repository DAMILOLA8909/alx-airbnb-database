-- ==========================================
-- Advanced SQL Joins Practice Script
-- File: joins_queries.sql
-- ==========================================

-- 🔹 Drop tables if they already exist (for repeatable execution)
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS properties;
DROP TABLE IF EXISTS users;

-- ==========================================
-- 1️⃣ Create Tables
-- ==========================================

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE properties (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    property_id INT,
    booking_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT,
    user_id INT,
    rating INT,
    comment TEXT,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ==========================================
-- 2️⃣ Insert Sample Data
-- ==========================================

-- 👤 Users
INSERT INTO users (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Brian Smith', 'brian@example.com'),
('Clara Davis', 'clara@example.com'),
('David Wilson', 'david@example.com');

-- 🏠 Properties
INSERT INTO properties (name, location) VALUES
('Seaside Villa', 'Lagos'),
('Mountain Lodge', 'Jos'),
('City Apartment', 'Abuja'),
('Country Cottage', 'Ibadan');

-- 📅 Bookings
INSERT INTO bookings (user_id, property_id, booking_date) VALUES
(1, 1, '2025-01-15'),
(2, 2, '2025-02-10'),
(3, 3, '2025-03-05');

-- 💬 Reviews
INSERT INTO reviews (property_id, user_id, rating, comment) VALUES
(1, 1, 5, 'Amazing stay with a great view!'),
(2, 2, 4, 'Cozy and clean. Would visit again.'),
(3, 3, 3, 'Nice but noisy neighborhood.');

-- ==========================================
-- 3️⃣ INNER JOIN Query
-- ==========================================

-- Retrieve all bookings and the respective users who made those bookings
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

-- ==========================================
-- 4️⃣ LEFT JOIN Query
-- ==========================================

-- Retrieve all properties and their reviews, including properties that have no reviews
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

-- ==========================================
-- 5️⃣ FULL OUTER JOIN (Simulated)
-- ==========================================

-- Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
-- Note: MySQL doesn’t support FULL OUTER JOIN directly, so we use UNION of LEFT + RIGHT joins.

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
