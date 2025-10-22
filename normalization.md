# Database Normalization - AirBnB Database

## Overview
This document explains the normalization process applied to the AirBnB database design. The goal is to ensure the schema is normalized to **Third Normal Form (3NF)** — eliminating redundancy, maintaining data integrity, and improving efficiency.

---

## 1️⃣ First Normal Form (1NF)
### Definition:
A table is in 1NF if:
- Each column contains **atomic (indivisible)** values.
- Each record is **unique**.

### Application:
- Each entity (User, Property, Booking, Payment, Review, Message) has a **primary key**.
- All attributes hold **atomic values** — e.g., `first_name`, `last_name`, `email` are single-valued.
- No repeating groups or multivalued attributes exist.

✅ **Result:** All tables satisfy **1NF**.

---

## 2️⃣ Second Normal Form (2NF)
### Definition:
A table is in 2NF if:
- It is in 1NF.
- All **non-key attributes** are **fully functionally dependent** on the **primary key**.

### Application:
- Each table’s attributes depend **entirely** on its primary key.
- No partial dependencies exist because:
  - `User` attributes depend on `user_id`.
  - `Property` attributes depend on `property_id`.
  - `Booking` attributes depend on `booking_id`.
  - `Payment` attributes depend on `payment_id`.
  - `Review` attributes depend on `review_id`.
  - `Message` attributes depend on `message_id`.

✅ **Result:** All tables satisfy **2NF**.

---

## 3️⃣ Third Normal Form (3NF)
### Definition:
A table is in 3NF if:
- It is in 2NF.
- There are **no transitive dependencies**, i.e., non-key attributes do not depend on other non-key attributes.

### Application:
- In the **User** table, all attributes depend only on `user_id`. (No attribute depends on `email` or `phone_number`.)
- In the **Property** table, details like `pricepernight`, `description`, `location`, etc., depend only on `property_id`.
- In the **Booking** table, `total_price`, `start_date`, `end_date`, and `status` depend solely on `booking_id`.
- In the **Payment** table, `amount`, `payment_date`, and `payment_method` depend on `payment_id`.
- In the **Review** table, `rating` and `comment` depend only on `review_id`.
- In the **Message** table, `message_body` and `sent_at` depend only on `message_id`.

✅ **Result:** All tables are in **Third Normal Form (3NF)**.

---

## ⚙️ Summary of Normalization
| Normal Form | Description | Status |
|--------------|--------------|---------|
| **1NF** | Atomic values and unique records | ✅ Achieved |
| **2NF** | Full dependency on primary key | ✅ Achieved |
| **3NF** | No transitive dependencies | ✅ Achieved |

---

## 🧠 Conclusion
The AirBnB database schema meets **Third Normal Form (3NF)** requirements.  
Each table has:
- A well-defined **primary key**
- No redundant or derived data
- Clear **foreign key relationships** to maintain referential integrity

This ensures data consistency, minimizes redundancy, and optimizes database performance for scalability and maintenance.

---