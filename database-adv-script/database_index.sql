-- ==========================================
-- DATABASE INDEX CREATION SCRIPT
-- File: database_index.sql
-- ==========================================

-- Identify high-usage columns:
-- users.user_id        → Used in JOINs with bookings
-- bookings.user_id     → Used in JOINs and filtering
-- bookings.property_id → Used in JOINs and aggregations
-- properties.property_id → Used in JOINs and ORDER BY
-- properties.name      → Used for search and sorting

-- ==========================================

-- 1️⃣ Identify High-Usage Columns
-- Columns frequently used in WHERE, JOIN, and ORDER BY:
-- - users.user_id
-- - bookings.user_id
-- - bookings.property_id
-- - properties.property_id

-- 2️⃣ Measure Query Performance BEFORE Indexing
EXPLAIN ANALYZE
SELECT 
    u.user_id,
    u.name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    users u
JOIN 
    bookings b ON u.user_id = b.user_id
GROUP BY 
    u.user_id
ORDER BY 
    total_bookings DESC;


-- ==========================================
-- 3️⃣ Create Indexes to Improve Performance
-- ==========================================

-- Index on user_id in bookings (speeds up joins with users)
CREATE INDEX idx_bookings_user_id
ON bookings(user_id);

-- Index on property_id in bookings (speeds up joins and aggregations)
CREATE INDEX idx_bookings_property_id
ON bookings(property_id);

-- Index on name in properties (useful for search or ORDER BY queries)
CREATE INDEX idx_properties_name
ON properties(name);

-- Composite index on (user_id, property_id) to optimize multi-column joins
CREATE INDEX idx_bookings_user_property
ON bookings(user_id, property_id);


-- 4️⃣ Measure Query Performance AFTER Indexing
EXPLAIN ANALYZE
SELECT 
    u.user_id,
    u.name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    users u
JOIN 
    bookings b ON u.user_id = b.user_id
GROUP BY 
    u.user_id
ORDER BY 
    total_bookings DESC;

-- ==========================================
--  VERIFY INDEXES
-- ==========================================
-- SHOW INDEX FROM bookings;
-- SHOW INDEX FROM properties;
-- SHOW INDEX FROM users;

-- ==========================================
-- PERFORMANCE TEST
-- ==========================================
-- Use EXPLAIN or ANALYZE to measure performance impact:

-- BEFORE adding indexes:
-- EXPLAIN SELECT u.name, b.booking_id
-- FROM users u
-- JOIN bookings b ON u.user_id = b.user_id;

-- AFTER adding indexes:
-- EXPLAIN SELECT u.name, b.booking_id
-- FROM users u
-- JOIN bookings b ON u.user_id = b.user_id;

-- Or use ANALYZE for more detailed runtime info:
-- ANALYZE SELECT u.name, b.booking_id
-- FROM users u
-- JOIN bookings b ON u.user_id = b.user_id;
