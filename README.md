# SQL Layoffs Data Cleaning and EDA Project

## Project Overview
This project focuses on cleaning and exploring a real-world layoffs dataset using **MySQL**.
The objective is to transform raw data into a clean, consistent format and then perform
**exploratory data analysis (EDA)** to identify trends and patterns.

This project follows a realistic data workflow:
**Raw Data → Data Cleaning → Exploratory Analysis**

---

## Tools Used
- MySQL
- SQL (CTEs, Window Functions, Aggregations)

---

## Dataset
The dataset contains information about company layoffs, including:
- Company name
- Location
- Industry
- Total and percentage of layoffs
- Date of layoff
- Company stage
- Country
- Funds raised

The raw dataset is available in the `data/layoffs.csv` file.

---

## Project Structure
sql-layoffs-data-cleaning/
│
├── README.md
├── layoffs_data_cleaning.sql -- SQL queries for data cleaning
├── eda_queries.sql -- SQL queries for exploratory data analysis
└── layoffs.csv -- raw dataset


---

## Data Cleaning
The data cleaning process is implemented in `layoffs_data_cleaning.sql` and includes:

- Creating staging tables to preserve raw data
- Removing duplicate records using `ROW_NUMBER()`
- Standardizing company names, industries, and countries
- Converting date column to proper `DATE` format
- Handling NULL and blank values
- Removing unnecessary helper columns

---

## Exploratory Data Analysis (EDA)
EDA is performed in `eda_queries.sql` to explore patterns and trends such as:

- Companies with the highest layoffs
- Industries and countries most affected
- Layoffs by company stage
- Yearly and monthly layoff trends
- Companies with 100% layoffs
- Rolling total of layoffs over time
- Top 5 companies by layoffs each year

---

## Results
After cleaning and analysis, the dataset is consistent, structured, and ready for:
- Business analysis
- Data visualization (Power BI / Tableau)
- Further statistical or machine learning work

---

## How to Use
1. Import `layoffs.csv` into MySQL as the `layoffs` table
2. Run `layoffs_data_cleaning.sql` to clean the data
3. Run `eda_queries.sql` to perform exploratory analysis

---

## Author
**Deepanshu**
