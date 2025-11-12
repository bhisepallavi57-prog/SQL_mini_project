CREATE DATABASE bank_management;
USE bank_management;

CREATE TABLE branch (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(50),
    branch_city VARCHAR(50)
);

CREATE TABLE customer (
    cust_id INT PRIMARY KEY AUTO_INCREMENT,
    cust_name VARCHAR(100),
    cust_address VARCHAR(255),
    cust_phone VARCHAR(15),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

CREATE TABLE account (
    acc_id INT PRIMARY KEY AUTO_INCREMENT,
    acc_type VARCHAR(20),
    balance DECIMAL(12,2),
    cust_id INT,
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);

CREATE TABLE transaction (
    trans_id INT PRIMARY KEY AUTO_INCREMENT,
    acc_id INT,
    trans_type VARCHAR(10),  -- 'DEPOSIT' or 'WITHDRAW'
    amount DECIMAL(10,2),
    trans_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (acc_id) REFERENCES account(acc_id)
);

CREATE TABLE employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100),
    emp_role VARCHAR(50),
    branch_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

INSERT INTO branch (branch_name, branch_city) VALUES
('Main Branch', 'Delhi'),
('City Branch', 'Mumbai');

INSERT INTO customer (cust_name, cust_address, cust_phone, branch_id) VALUES
('Amit Sharma', 'Delhi', '9876543210', 1),
('Priya Singh', 'Mumbai', '9123456780', 2);

INSERT INTO account (acc_type, balance, cust_id) VALUES
('SAVINGS', 15000, 1),
('CURRENT', 50000, 2);

-- Show all customers with their branch
SELECT c.cust_name, b.branch_name 
FROM customer c 
JOIN branch b ON c.branch_id = b.branch_id;

-- Deposit money
UPDATE account SET balance = balance + 5000 WHERE acc_id = 1;

SELECT c.cust_name, a.acc_type, a.balance, b.branch_name
FROM customer c
JOIN account a ON c.cust_id = a.cust_id
JOIN branch b ON c.branch_id = b.branch_id;

CREATE VIEW view_customer_balance AS
SELECT c.cust_name, a.acc_type, a.balance
FROM customer c
JOIN account a ON c.cust_id = a.cust_id;

CREATE USER 'bank_user'@'localhost' IDENTIFIED BY 'bank123';
GRANT SELECT, INSERT, UPDATE ON bank_management.* TO 'bank_user'@'localhost';
FLUSH PRIVILEGES;

START TRANSACTION;

UPDATE account SET balance = balance - 2000 WHERE acc_id = 1;
UPDATE account SET balance = balance + 2000 WHERE acc_id = 2;

COMMIT;
-- or ROLLBACK;













