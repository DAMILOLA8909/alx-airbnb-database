-- =========================================
-- AirBnB Database Seeding Script
-- File: seed.sql
-- =========================================

-- Insert Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
('u1', 'Alice', 'Johnson', 'alice@example.com', 'hash123', '08012345678', 'host', CURRENT_TIMESTAMP),
('u2', 'Bob', 'Williams', 'bob@example.com', 'hash234', '08023456789', 'guest', CURRENT_TIMESTAMP),
('u3', 'Clara', 'Brown', 'clara@example.com', 'hash345', '08034567890', 'guest', CURRENT_TIMESTAMP),
('u4', 'David', 'Smith', 'david@example.com', 'hash456', '08045678901', 'host', CURRENT_TIMESTAMP);

-- Insert Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
('p1', 'u1', 'Seaside Villa', 'Luxury villa with ocean view', 'Lagos Island', 50000.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('p2', 'u4', 'Urban Apartment', 'Modern apartment in city center', 'Abuja', 35000.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
('b1', 'p1', 'u2', '2025-10-10', '2025-10-13', 150000.00, 'confirmed', CURRENT_TIMESTAMP),
('b2', 'p2', 'u3', '2025-11-01', '2025-11-04', 105000.00, 'pending', CURRENT_TIMESTAMP);

-- Insert Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
('pay1', 'b1', 150000.00, CURRENT_TIMESTAMP, 'credit_card'),
('pay2', 'b2', 105000.00, CURRENT_TIMESTAMP, 'paypal');

-- Insert Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
('r1', 'p1', 'u2', 5, 'Amazing stay! Great host and perfect view.', CURRENT_TIMESTAMP),
('r2', 'p2', 'u3', 4, 'Nice and clean apartment, will come again.', CURRENT_TIMESTAMP);

-- Insert Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
('m1', 'u2', 'u1', 'Hello Alice, is the villa available next weekend?', CURRENT_TIMESTAMP),
('m2', 'u1', 'u2', 'Hi Bob! Yes, it’s available for booking.', CURRENT_TIMESTAMP),
('m3', 'u3', 'u4', 'Hi David, can I check in earlier?', CURRENT_TIMESTAMP),
('m4', 'u4', 'u3', 'Sure, early check-in is fine.', CURRENT_TIMESTAMP);

-- =========================================
-- Verification Queries (Optional)
-- =========================================
-- SELECT * FROM User;
-- SELECT * FROM Property;
-- SELECT * FROM Booking;
-- SELECT * FROM Payment;
-- SELECT * FROM Review;
-- SELECT * FROM Message;
