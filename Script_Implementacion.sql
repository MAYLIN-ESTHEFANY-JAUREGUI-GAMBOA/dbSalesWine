USE master
GO
DROP DATABASE IF EXISTS dbSalesWine
GO

CREATE DATABASE dbSalesWine
GO

USE dbSalesWine
GO
SET DATEFORMAT dmy
GO

-- Table: persons
CREATE TABLE persons (
    id INT IDENTITY(100,1) NOT NULL,
    number_dni CHAR(8) UNIQUE CHECK (LEN(number_dni) = 8),
    names VARCHAR(60) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    cell_phone CHAR(9) UNIQUE CHECK (LEN(cell_phone) = 9),
    email VARCHAR(70) UNIQUE CHECK (email LIKE '%_@__%.%'),
    birthday DATE CHECK (birthday <= DATEADD(YEAR, -18, GETDATE())),
    type_person CHAR(1) CHECK (type_person IN ('C', 'V', 'J')),
    active CHAR(1) NOT NULL CONSTRAINT DF_persons_active DEFAULT 'A',
    CONSTRAINT persons_pk PRIMARY KEY (id)
);


-- Table: product
CREATE TABLE product (
    code CHAR(3) NOT NULL CHECK (code LIKE 'P[0-9][0-9]'),
    names VARCHAR(70) NOT NULL,
    type CHAR(1) NOT NULL CHECK (type IN ('V', 'P', 'T', 'W')),
    volume INT NOT NULL CHECK (volume IN (250, 500, 750)),
    country CHAR(1) NOT NULL CHECK (country IN ('P', 'A', 'C', 'E', 'M')),
    price DECIMAL(8,2) NOT NULL,
    stock INT NOT NULL,
    state CHAR(1) NOT NULL CHECK (state IN ('A', 'I')),
    CONSTRAINT product_pk PRIMARY KEY (code)
);

-- Table: sale
CREATE TABLE sale (
    id INT IDENTITY(1,1) NOT NULL,
    date DATETIME DEFAULT GETDATE() NOT NULL,
    type_pay CHAR(1) NOT NULL CHECK (type_pay IN ('E', 'T', 'Y', 'P')),
    type_delivery CHAR(1) NOT NULL CHECK (type_delivery IN ('D', 'T')),
    status CHAR(1) DEFAULT 'A' NOT NULL CHECK (status IN ('A', 'I')),
    person_id INT NOT NULL,
    seller_id INT NOT NULL,
    CONSTRAINT sale_pk PRIMARY KEY (id),
    CONSTRAINT sale_person_fk FOREIGN KEY (person_id) REFERENCES persons (id),
    CONSTRAINT sale_seller_fk FOREIGN KEY (seller_id) REFERENCES persons (id)
);

-- Table: sale_detail
CREATE TABLE sale_detail (
    id INT IDENTITY(1,1) NOT NULL,
    amount INT NOT NULL,
    sale_id INT NOT NULL,
    product_code CHAR(3) NOT NULL,
    CONSTRAINT sale_detail_pk PRIMARY KEY (id),
    CONSTRAINT sale_detail_amount_check CHECK (amount >= 0),
    CONSTRAINT sale_detail_product_fk FOREIGN KEY (product_code) REFERENCES product (code),
    CONSTRAINT sale_detail_sale_fk FOREIGN KEY (sale_id) REFERENCES sale (id)
);


