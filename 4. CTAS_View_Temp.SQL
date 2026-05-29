-- LEARN DML

-- Select a flattened set of job postings with company details
USE job_mart;

--- QUERY ORIGINAL TABLE THAT I WANT TO CREATE
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name,
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;

--CREATE TABLE
CREATE TABLE staging.job_postings_flat AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name,
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id;

---CHECK NEW TABLE
SELECT COUNT(*)
FROM staging.job_postings_flat
LIMIT 10;

DROP TABLE staging.job_postings_flat;

---CREATE VIEW
CREATE VIEW staging.priority_jobs_flat_view AS
SELECT
    jpf.*
FROM staging.job_postings_flat AS jpf
JOIN staging.priority_roles AS r
    ON jpf.job_title_short = r.role_name
    WHERE r.priority_lvl = 1;


---CREATE TEMP TABLE
CREATE TEMPORARY TABLE senior_jobs_flat_temp AS
SELECT
    *
From staging.job_postings_flat
WHERE job_title_short = 'Senior Data Engineer';

---VIEW TEMP TABLE
SELECT
    job_title_short,
    COUNT(*) AS job_count
FROM senior_jobs_flat_temp
GROUP BY job_title_short
ORDER BY job_count DESC;


--CHECK VALUES BEFORE DELETE
SELECT
    COUNT(*) FROM staging.job_postings_flat;
SELECT
    COUNT(*) FROM senior_jobs_flat_temp;
SELECT
    COUNT(*) FROM staging.priority_jobs_flat_view;

---DELETE (targets certain rows) AND TRUNCATE (deletes all data)
DELETE FROM staging.job_postings_flat
WHERE job_posted_date < '2024-01-01';

---CHECK VALUES AFTER DELETE
SELECT
    COUNT(*) FROM staging.job_postings_flat;
SELECT
    COUNT(*) FROM senior_jobs_flat_temp;
SELECT
    COUNT(*) FROM staging.priority_jobs_flat_view;

---TRUNCATE
TRUNCATE TABLE staging.job_postings_flat;

--check truncate
SELECT *
FROM staging.job_postings_flat;

--fill-in again

INSERT INTO staging.job_postings_flat
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name,
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE job_posted_date >= '2024-01-01';

SELECT
    COUNT(*) FROM staging.job_postings_flat;