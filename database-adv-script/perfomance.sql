-- ==========================================
-- SQL Performance Optimization Script
-- File: perfomance.sql
-- ==========================================

-- 0️⃣ Create Helpful Indexes (to optimize joins and filtering)
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_booking_id ON bookings(booking_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_users_user_id ON users(user_id);
CREATE INDEX idx_properties_property_id ON properties(property_id);

-- ==========================================
-- 1️⃣ Initial Query (Unoptimized)
-- Retrieve all bookings along with user, property, and payment details
-- ==========================================

EXPLAIN
SELECT 
    b.booking_id,
    b.booking_date,
    b.check_in_date,
    b.check_out_date,
    u.user_id,
    u.name AS user_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id;

-- ==========================================
-- 2️⃣ Refactored Query (Optimized)
-- Optimizations applied:
-- - Reduced columns selected
-- - Changed LEFT JOIN → INNER JOIN (assuming all bookings have payments)
-- - Aliased tables for readability
-- - Indexes ensure faster lookup
-- ==========================================

EXPLAIN
SELECT 
    b.booking_id,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount AS total_paid,
    pay.status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
JOIN 
    payments pay ON b.booking_id = pay.booking_id;
