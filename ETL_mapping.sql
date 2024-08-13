--Senaryo
--Bir e-ticaret sisteminden müşteri ve sipariş verilerini bir veri ambarına taşımak istiyoruz.
--Kaynak veritabanında customers ve orders tabloları var ve bu verileri veri ambarındaki dim_customers ve fact_orders tablolarına taşımak istiyoruz.

--Kaynak Tablolar
--customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    created_at TIMESTAMPTZ
);

---------------------

--orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMPTZ,
    amount DECIMAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

----------------------------------

-- Hedef Tablolar
--dim_customers

CREATE TABLE dim_customers (
    customer_key INT PRIMARY KEY,
    full_name TEXT,
    email TEXT,
    created_at TIMESTAMPTZ
);

-------------------------------------

--fact_orders

CREATE TABLE fact_orders (
    order_key INT PRIMARY KEY,
    customer_key INT,
    order_date TIMESTAMPTZ,
    amount DECIMAL,
    FOREIGN KEY (customer_key) REFERENCES dim_customers(customer_key)
);


-----------------------------------------

--ETL Süreci
--1. Extract
--Kaynak veritabanından verileri çıkarma işlemi.


-- Extract customers
SELECT customer_id, first_name, last_name, email, created_at
FROM customers;

-- Extract orders
SELECT order_id, customer_id, order_date, amount
FROM orders;


-------------------------------------------

--2. Transform
--Verileri dönüştürme işlemi. Örneğin, müşteri adlarını birleştirme.


-- Transform customers
SELECT 
    customer_id AS customer_key,
    CONCAT(first_name, ' ', last_name) AS full_name,
    email,



