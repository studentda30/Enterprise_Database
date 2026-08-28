/*******************************************************************************
   Project: Production-Scale Enterprise Retail ERP Database 
   DB Engine: MySQL
********************************************************************************/

DROP DATABASE IF EXISTS EnterpriseRetailDB;
CREATE DATABASE EnterpriseRetailDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE EnterpriseRetailDB;
-- 1. COUNTRIES LOOKUP TABLE
CREATE TABLE Countries (
    CountryCode CHAR(2) NOT NULL,
    CountryName VARCHAR(100) NOT NULL,
    Continent VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Countries PRIMARY KEY (CountryCode)
) ENGINE=InnoDB;

-- 2. EMPLOYEES TABLE (Self-referencing management hierarchy)
CREATE TABLE Employees (
    EmployeeId INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    ReportsTo INT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Salary DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Employees PRIMARY KEY (EmployeeId),
    CONSTRAINT FK_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES Employees (EmployeeId) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 3. CUSTOMERS TABLE
CREATE TABLE Customers (
    CustomerId INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(25) NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_Customers PRIMARY KEY (CustomerId)
) ENGINE=InnoDB;

-- 4. ADDRESSES TABLE
CREATE TABLE Addresses (
    AddressId INT NOT NULL AUTO_INCREMENT,
    CustomerId INT NOT NULL,
    AddressLine VARCHAR(150) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(15) NOT NULL,
    CountryCode CHAR(2) NOT NULL,
    IsDefault TINYINT(1) DEFAULT 0,
    CONSTRAINT PK_Addresses PRIMARY KEY (AddressId),
    CONSTRAINT FK_Addresses_Customers FOREIGN KEY (CustomerId) REFERENCES Customers (CustomerId) ON DELETE CASCADE,
    CONSTRAINT FK_Addresses_Countries FOREIGN KEY (CountryCode) REFERENCES Countries (CountryCode)
) ENGINE=InnoDB;
-- 5. SHIPPERS TABLE
CREATE TABLE Shippers (
    ShipperId INT NOT NULL AUTO_INCREMENT,
    CompanyName VARCHAR(100) NOT NULL,
    Phone VARCHAR(25) NULL,
    CONSTRAINT PK_Shippers PRIMARY KEY (ShipperId)
) ENGINE=InnoDB;

-- 6. SUPPLIERS TABLE
CREATE TABLE Suppliers (
    SupplierId INT NOT NULL AUTO_INCREMENT,
    CompanyName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(50) NULL,
    Phone VARCHAR(25) NULL,
    CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierId)
) ENGINE=InnoDB;

-- 7. BRANDS TABLE
CREATE TABLE Brands (
    BrandId INT NOT NULL AUTO_INCREMENT,
    BrandName VARCHAR(50) NOT NULL,
    Website VARCHAR(150) NULL,
    CONSTRAINT PK_Brands PRIMARY KEY (BrandId)
) ENGINE=InnoDB;

-- 8. CATEGORIES TABLE
CREATE TABLE Categories (
    CategoryId INT NOT NULL AUTO_INCREMENT,
    CategoryName VARCHAR(50) NOT NULL,
    Description TEXT NULL,
    CONSTRAINT PK_Categories PRIMARY KEY (CategoryId)
) ENGINE=InnoDB;

-- 9. PRODUCTS TABLE
CREATE TABLE Products (
    ProductId INT NOT NULL AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    CategoryId INT NOT NULL,
    SupplierId INT NOT NULL,
    BrandId INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    QuantityInStock INT NOT NULL DEFAULT 0,
    SKU VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT PK_Products PRIMARY KEY (ProductId),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId) REFERENCES Categories (CategoryId),
    CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierId) REFERENCES Suppliers (SupplierId),
    CONSTRAINT FK_Products_Brands FOREIGN KEY (BrandId) REFERENCES Brands (BrandId)
) ENGINE=InnoDB;

-- 10. ORDERS TABLE
CREATE TABLE Orders (
    OrderId INT NOT NULL AUTO_INCREMENT,
    CustomerId INT NOT NULL,
    ShipperId INT NULL,
    EmployeeId INT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ShippingAddressId INT NOT NULL,
    OrderStatus VARCHAR(30) NOT NULL DEFAULT 'Pending',
    CONSTRAINT PK_Orders PRIMARY KEY (OrderId),
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerId) REFERENCES Customers (CustomerId),
    CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipperId) REFERENCES Shippers (ShipperId),
    CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeId) REFERENCES Employees (EmployeeId) ON DELETE SET NULL,
    CONSTRAINT FK_Orders_Addresses FOREIGN KEY (ShippingAddressId) REFERENCES Addresses (AddressId)
) ENGINE=InnoDB;

-- 11. ORDER ITEMS TABLE
CREATE TABLE OrderItems (
    OrderItemId INT NOT NULL AUTO_INCREMENT,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    ItemPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_OrderItems PRIMARY KEY (OrderItemId),
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderId) REFERENCES Orders (OrderId) ON DELETE CASCADE,
    CONSTRAINT FK_OrderItems_Products FOREIGN KEY (ProductId) REFERENCES Products (ProductId)
) ENGINE=InnoDB;

-- 12. PAYMENTS TABLE
CREATE TABLE Payments (
    PaymentId INT NOT NULL AUTO_INCREMENT,
    OrderId INT NOT NULL,
    PaymentDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentStatus VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Payments PRIMARY KEY (PaymentId),
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderId) REFERENCES Orders (OrderId) ON DELETE CASCADE
) ENGINE=InnoDB;

-- PERFORMANCE LOOKUP INDEXES
CREATE INDEX IDX_Products_Name ON Products (ProductName);
CREATE INDEX IDX_Orders_Date ON Orders (OrderDate);
CREATE INDEX IDX_Orders_Employee ON Orders (EmployeeId);
CREATE INDEX IDX_Customers_Name ON Customers (LastName, FirstName);