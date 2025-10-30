-- ==========================================
-- SQL Table Partitioning Script
-- File: partitioning.sql
-- ==========================================

-- 1️⃣ Drop existing partitioned table if it exists
DROP TABLE IF EXISTS bookings_partitioned;

-- 2️⃣ Create a new partitioned table based on start_date
-- Partitioning improves query performance by allowing MySQL to scan only relevant data partitions
CREATE TABLE bookings_partitioned (
    booking_id INT PRIMARY KEY,
    user_id INT,
    property_id INT,
    start_date DATE,
    end_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(50)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- 3️⃣ Insert data from the main bookings table (for demonstration)
INSERT INTO bookings_partitioned
SELECT booking_id, user_id, property_id, check_in_date AS start_date, check_out_date AS end_date, amount, status
FROM bookings;

-- 4️⃣ Test query performance before and after partitioning using EXPLAIN ANALYZE
-- Example: Fetch bookings within a specific date range

-- Before partitioning (on the original table)
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE check_in_date BETWEEN '2025-01-01' AND '2025-03-31';

-- After partitioning (on the partitioned table)
EXPLAIN ANALYZE
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2025-01-01' AND '2025-03-31';
