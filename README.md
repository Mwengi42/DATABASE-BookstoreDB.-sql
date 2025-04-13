# 📚 Bookstore Database Design & Programming Project

## Overview

This project simulates a real-world Bookstore database system, designed using MySQL and visualized through an Entity-Relationship Diagram (ERD). It includes database creation, relational schema design, access control, and test queries. The database supports essential operations such as managing books, authors, customers, orders, addresses, and shipping.

## 📦 Features

- Structured relational schema covering all bookstore operations
- Many-to-many relationship management (books & authors)
- Secure user access with roles and privileges
- Sample SQL queries for reporting and analysis
- ERD diagram included for visual schema understanding

## 🛠️ Tools & Technologies

- **MySQL** — Relational database management
- **Draw.io** — ERD creation and schema visualization
- **SQL** — Language for database creation and querying

## 🧱 Database Tables

| Table Name         | Description |
|--------------------|-------------|
| `book`             | Stores book information |
| `author`           | Stores author details |
| `book_author`      | Many-to-many relationship between books and authors |
| `publisher`        | List of book publishers |
| `book_language`    | Supported languages for books |
| `customer`         | Bookstore customer records |
| `address`          | List of physical addresses |
| `address_status`   | Address type (e.g., current, old) |
| `country`          | Country list for addresses |
| `customer_address` | Links customers to multiple addresses |
| `cust_order`       | Orders placed by customers |
| `order_line`       | Line items within each order |
| `order_status`     | Statuses like pending, shipped, delivered |
| `order_history`    | Tracks status change history for orders |
| `shipping_method`  | Shipping options with pricing |

## 👤 User Management

- `bookstore_admin`: Full access to all tables
- `bookstore_reader`: Read-only access to all tables

> Passwords and credentials are configured in the SQL file. Make sure to secure them appropriately in a production environment.

## 📄 Files Included

- `bookstore_project.sql` — Full SQL script to create and configure the database
- `bookstore_erd.png` — Visual representation of the database schema (ERD)
- `README.md` — Project overview and usage instructions

## ▶️ How to Run

1. **Open MySQL** on your system.
2. **Run the SQL file**:
   ```bash
   mysql -u root -p < bookstore_project.sql
