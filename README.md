
## Enterprise Database

**Enterprise Database — Enterprise Database — MySQL relational database project with SQL schema, dataset, ERD, primary/foreign keys, constraints, and business data analysis.**

## 📌 Project Overview

This project demonstrates the design and implementation of an **Enterprise Database** using **MySQL**. It includes structured relational tables, primary and foreign keys, constraints, sample datasets, database schema, and an **ERD (Entity Relationship Diagram)**.

## 🗂️ Tables

The database contains **12 tables**:

1. Products
2. Suppliers
3. Brands
4. Categories
5. OrderItems
6. Orders
7. Payments
8. Employees
9. Shippers
10. Customers
11. Addresses
12. Countries

## 🔗 Relationships

1. Products → Categories — **Many-to-One (M:1)**
2. Products → Suppliers — **Many-to-One (M:1)**
3. Products → Brands — **Many-to-One (M:1)**
4. OrderItems → Orders — **Many-to-One (M:1)**
5. OrderItems → Products — **Many-to-One (M:1)**
6. Orders → Customers — **Many-to-One (M:1)**
7. Orders → Employees — **Many-to-One (M:1)**
8. Orders → Shippers — **Many-to-One (M:1)**
9. Orders → Addresses — **Many-to-One (M:1)**
10. Payments → Orders — **Many-to-One (M:1)**
11. Customers → Addresses — **One-to-Many (1:M)**
12. Addresses → Countries — **Many-to-One (M:1)**
13. Employees → Employees — **Self-Referencing (SELF)**

## 🛠️ Technologies

* MySQL
* SQL
* MySQL Workbench

## 📁 Project Contents

* **Database Schema** — The SQL schema contains the table definitions, primary keys, foreign keys, and constraints used to build the Enterprise Database.
* **Dataset** — Sample records for the tables
* **ERD** — Entity Relationship Diagram showing table relationships
* **SQL Queries** — Database operations and analysis

## 📊 ERD

The ERD represents the relationships and connections between all database entities.


### Repository

[Enterprise_Database](https://github.com/studentda30/Enterprise_Database)
