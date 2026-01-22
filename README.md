# SQL Layoffs Data Cleaning Project

##  Project Overview
This project focuses on cleaning a real-world layoffs dataset using **MySQL**.  
The goal is to prepare raw data for analysis by removing duplicates, fixing
inconsistencies, handling NULL values, and formatting dates properly.

---

##  Tools Used
- MySQL
- SQL (Window Functions, CTEs)

---

## 📂 Project Files
- `layoffs_data_cleaning.sql` → SQL script used for data cleaning  
- `data/layoffs.csv` (or similar) → Raw layoffs dataset  

---

## Data Cleaning Steps

### 1. Create Staging Tables
- Copied raw data into staging tables to avoid modifying original data.

### 2. Remove Duplicates
- Used `ROW_NUMBER()` with `PARTITION BY`
- Removed duplicate rows safely using a second staging table.

### 3. Standardize Data
- Trimmed company names
- Standardized industry names (e.g., crypto)
- Standardized country names
- Converted date column to proper `DATE` format.

### 4. Handle NULL and Blank Values
- Replaced blank industries with NULL
- Filled missing industry values using self joins
- Removed rows with no layoff information.

### 5. Remove Unnecessary Columns
- Dropped helper columns used during cleaning.

---

##  Result
A clean and consistent dataset ready for analysis and visualization.

---

## 👤 Author
**Deepanshu**
