/*
Project: Layoffs Data Cleaning
Database: MySQL

Steps:
1. Create staging table
2. Remove duplicates
3. Standardize data
4. Handle null / blank values
5. Remove extra columns
*/

-- 1. CREATE STAGING TABLE

SELECT *
FROM layoffs;

CREATE TABLE layoff_staging
LIKE layoffs;

INSERT INTO layoff_staging
SELECT *
FROM layoffs;


-- 2. REMOVE DUPLICATES

WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry,
                            total_laid_off, percentage_laid_off,
                            `date`, stage, country, funds_raised_millions
           ) AS row_num
    FROM layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;


CREATE TABLE layoff_staging2 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT,
    row_num INT
);

INSERT INTO layoff_staging2
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY company, location, industry,
                        total_laid_off, percentage_laid_off,
                        `date`, stage, country, funds_raised_millions
       ) AS row_num
FROM layoff_staging;

SET SQL_SAFE_UPDATES = 0;

DELETE
FROM layoff_staging2
WHERE row_num > 1;


-- 3. STANDARDIZE DATA

UPDATE layoff_staging2
SET company = TRIM(company);

UPDATE layoff_staging2
SET industry = 'crypto'
WHERE industry LIKE 'crypto%';

UPDATE layoff_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';


-- 4. DATE FORMAT FIX

UPDATE layoff_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;


-- 5. HANDLE NULL / BLANK VALUES

UPDATE layoff_staging2
SET industry = NULL
WHERE industry = '';

UPDATE layoff_staging2 t1
JOIN layoff_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

DELETE
FROM layoff_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;


-- 6. REMOVE EXTRA COLUMN

ALTER TABLE layoff_staging2
DROP COLUMN row_num;


-- FINAL DATA

SELECT *
FROM layoff_staging2;
