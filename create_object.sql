-- create database
CREATE DATABASE OneU;
go

USE OneU;
GO

-- create schemas
CREATE SCHEMA voucher;
go

-- create tables
CREATE TABLE voucher.fact (
	transaction_id INT NOT NULL PRIMARY KEY,
	serial_number VARCHAR (255) NOT NULL,
    voucher_code VARCHAR (255) NOT NULL,
    merchant_code VARCHAR (255) NOT NULL,
    action VARCHAR (255) NOT NULL,
    calendar_dim_id DATE NOT NULL,
    user_id VARCHAR (255) NOT NULL
);

CREATE TABLE voucher.d_scheme (
    discount_type VARCHAR (255) NOT NULL,
    discount_amount DECIMAL (10, 2) NOT NULL,
    discount_percent DECIMAL (10, 2) NOT NULL,
    description NVARCHAR (255),
    voucher_code VARCHAR (255) NOT NULL PRIMARY KEY
);

CREATE TABLE voucher.d_voucher (
    voucher_code VARCHAR (255) NOT NULL PRIMARY KEY,
    voucher_name NVARCHAR (255),
    total_stock INT NOT NULL,
    display_date_from DATETIME NOT NULL,
    display_date_to DATETIME NOT NULL,
);

CREATE TABLE voucher.d_merchant (
    merchant_code VARCHAR (255) NOT NULL PRIMARY KEY,
    category NVARCHAR (255) NOT NULL,
    sub_category NVARCHAR (255) NOT NULL,
);

CREATE TABLE voucher.d_user (
    user_id VARCHAR (255) NOT NULL PRIMARY KEY,
    gender VARCHAR (25) NOT NULL,
    province_name NVARCHAR (255) NOT NULL,
    age_group VARCHAR(25)
);




