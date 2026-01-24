-- exploratory data analysis

select *
from layoff_staging2;


-- basic stats

select max(total_laid_off), max(percentage_laid_off)
from layoff_staging2;


-- companies with 100% layoffs

select *
from layoff_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

select *
from layoff_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;


-- total layoffs by company

select company, sum(total_laid_off)
from layoff_staging2
group by company
order by 2 desc;


-- date range

select min(`date`), max(`date`)
from layoff_staging2;


-- layoffs by industry

select industry, sum(total_laid_off)
from layoff_staging2
group by industry
order by 2 desc;


-- layoffs by country

select country, sum(total_laid_off)
from layoff_staging2
group by country
order by 2 desc;


-- layoffs by date

select `date`, sum(total_laid_off)
from layoff_staging2
group by `date`
order by 2 desc;


-- layoffs by year

select year(`date`), sum(total_laid_off)
from layoff_staging2
group by year(`date`)
order by 1 desc;


-- layoffs by company stage

select stage, sum(total_laid_off)
from layoff_staging2
group by stage
order by 2 desc;


-- average layoff percentage by company

select company, avg(percentage_laid_off)
from layoff_staging2
group by company
order by 2 desc;


-- monthly layoffs

select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoff_staging2
where `date` is not null
group by `month`
order by 1 asc;


-- rolling total layoffs by month

with rolling_total as
(
    select substring(`date`,1,7) as `month`,
           sum(total_laid_off) as total_off
    from layoff_staging2
    where `date` is not null
    group by `month`
)
select `month`, total_off,
       sum(total_off) over(order by `month`) as rolling_total
from rolling_total;


-- layoffs by company and year

select company, year(`date`), sum(total_laid_off)
from layoff_staging2
group by company, year(`date`)
order by 3 desc;


-- top 5 companies by layoffs each year

with company_year as
(
    select company, year(`date`) as years,
           sum(total_laid_off) as total_laid_off
    from layoff_staging2
    group by company, years
),
company_year_rank as
(
    select *,
           dense_rank() over(partition by years order by total_laid_off desc) as ranking
    from company_year
    where years is not null
)
select *
from company_year_rank
where ranking <= 5;
