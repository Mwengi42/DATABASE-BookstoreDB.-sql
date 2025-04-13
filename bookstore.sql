-- ========================================
-- Bookstore Database Project SQL File
-- ========================================

-- Step 1: Create the Database
DROP DATABASE IF EXISTS BookstoreDB;
CREATE DATABASE BookstoreDB;
USE BookstoreDB;

-- Step 2: Tables

-- Country Table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL UNIQUE
);

-- Address Table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Address Status Table
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

-- Customer Table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20)
);

-- Customer Address Table
CREATE TABLE customer_address (
    cust_addr_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Publisher Table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    website VARCHAR(255)
);

-- Book Language Table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL UNIQUE
);

-- Author Table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- Book Table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publication_year YEAR,
    price DECIMAL(10,2),
    publisher_id INT,
    language_id INT,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- Book Author (Many-to-Many)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Shipping Method Table
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL UNIQUE,
    cost DECIMAL(6,2)
);

-- Order Status Table
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

-- Customer Order Table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Order Line Table
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price_each DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Order History Table
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Step 3: User Roles and Permissions

-- Admin User
CREATE USER IF NOT EXISTS 'bookstore_admin'@'localhost' IDENTIFIED BY 'AdminPass123!';
GRANT ALL PRIVILEGES ON BookstoreDB.* TO 'bookstore_admin'@'localhost';

-- Read-Only User
CREATE USER IF NOT EXISTS 'bookstore_reader'@'localhost' IDENTIFIED BY 'ReaderPass123!';
GRANT SELECT ON BookstoreDB.* TO 'bookstore_reader'@'localhost';

FLUSH PRIVILEGES;

-- Step 4: Sample Queries to Test

-- 1. List of all books with authors
-- (Assumes test data is inserted)
-- SELECT b.title, CONCAT(a.first_name, ' ', a.last_name) AS author
-- FROM book b
-- JOIN book_author ba ON b.book_id = ba.book_id
-- JOIN author a ON ba.author_id = a.author_id;

-- 2. Orders with customer names and status
-- SELECT o.order_id, CONCAT(c.first_name, ' ', c.last_name) AS customer, os.status_name, o.order_date
-- FROM cust_order o
-- JOIN customer c ON o.customer_id = c.customer_id
-- JOIN order_status os ON o.status_id = os.status_id;

-- 3. Total revenue per book
-- SELECT b.title, SUM(ol.quantity * ol.price_each) AS total_revenue
-- FROM order_line ol
-- JOIN book b ON ol.book_id = b.book_id
-- GROUP BY b.title
-- ORDER BY total_revenue DESC;

-- End of File
