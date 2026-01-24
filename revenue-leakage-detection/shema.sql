-- Revenue Leakage Detection System
-- Database Schema

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50),
    signup_date DATE
);

CREATE TABLE invoices (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_date DATE,
    invoice_amount DECIMAL(10,2),
    discount_applied DECIMAL(10,2),
    final_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    invoice_id INT,
    payment_date DATE,
    paid_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id)
);

CREATE TABLE refunds (
    refund_id INT PRIMARY KEY,
    invoice_id INT,
    refund_date DATE,
    refund_amount DECIMAL(10,2),
    refund_reason VARCHAR(100),
    FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id)
);
