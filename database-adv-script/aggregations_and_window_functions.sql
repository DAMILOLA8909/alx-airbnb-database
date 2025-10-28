-- ==========================================
-- SQL Aggregation and Window Functions
-- File: aggregations_and_window_functions.sql
-- ==========================================

-- Drop tables if they already exist (for a clean run)
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS properties;
DROP TABLE IF EXISTS users;

-- ==========================================
-- TABLE CREATION
-- ==========================================
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE properties (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    property_id INT,
    booking_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);

-- ==========================================
-- SAMPLE DATA
-- ==========================================

-- Insert Users
INSERT INTO users (name) VALUES 
('Alice Johnson'),
('Brian Smith'),
('Cynthia Lee'),
('David Brown'),
('Ella Turner');

-- Insert Properties
INSERT INTO properties (name) VALUES 
('Ocean View Apartment'),
('Mountain Cabin'),
('City Center Loft'),
('Country House'),
('Beach Villa');

-- Insert Bookings
INSERT INTO bookings (user_id, property_id, booking_date) VALUES
(1, 1, '2025-01-05'),
(1, 3, '2025-02-12'),
(2, 2, '2025-02-20'),
(2, 2, '2025-03-18'),
(2, 5, '2025-04-09'),
(3, 1, '2025-05-10'),
(3, 1, '2025-06-15'),
(3, 4, '2025-07-22'),
(4, 5, '2025-08-05'),
(4, 3, '2025-09-01'),
(4, 3, '2025-09-18'),
(5, 5, '2025-10-10');

-- ==========================================
-- 1️⃣ Aggregation Query
-- ==========================================
-- Find the total number of bookings made by each user

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


-- ==========================================
-- 2️⃣ Window Function Query (RANK)
-- ==========================================
-- Rank properties based on the total number of bookings they have received

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


-- ==========================================
-- 3️⃣ Window Function Query (ROW_NUMBER)
-- ==========================================
-- Assign a unique row number to each property ordered by total bookings

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
