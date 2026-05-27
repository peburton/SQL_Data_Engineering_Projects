/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(salary_year_avg)) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
GROUP BY
    sd.skills
HAVING
    median_salary >= 100_000 AND demand_count > 1000
ORDER BY
    median_salary DESC
LIMIT 100;

/*
──────────────┬───────────────┬──────────────┐
│    skills    │ median_salary │ demand_count │
│   varchar    │    double     │    int64     │
├──────────────┼───────────────┼──────────────┤
│ terraform    │      184000.0 │         3248 │
│ kubernetes   │      150500.0 │         4202 │
│ airflow      │      150000.0 │         9996 │
│ kafka        │      145000.0 │         6415 │
│ spark        │      140000.0 │        12799 │
│ git          │      140000.0 │         4641 │
│ pyspark      │      140000.0 │         4898 │
│ pandas       │      140000.0 │         2929 │
│ go           │      140000.0 │         1997 │
│ aws          │      137320.0 │        17823 │
│ scala        │      137290.0 │         6304 │
│ gcp          │      136000.0 │         6446 │
│ dynamodb     │      136000.0 │         1082 │
│ looker       │      136000.0 │         1574 │
│ mongodb      │      135750.0 │         3512 │
│ snowflake    │      135500.0 │         8639 │
│ bigquery     │      135000.0 │         3523 │
│ docker       │      135000.0 │         4316 │
│ github       │      135000.0 │         1987 │
│ python       │      135000.0 │        28776 │
│   ·          │          ·    │           ·  │
│   ·          │          ·    │           ·  │
│   ·          │          ·    │           ·  │
│ gitlab       │      130000.0 │         1047 │
│ azure        │      128000.0 │        14143 │
│ cassandra    │      127000.0 │         1125 │
│ flow         │      125500.0 │         3063 │
│ shell        │      125000.0 │         1467 │
│ oracle       │      124500.0 │         3286 │
│ postgresql   │      122500.0 │         3360 │
│ c#           │      122500.0 │         1187 │
│ sql server   │      120000.0 │         3931 │
│ power bi     │      120000.0 │         4600 │
│ ssis         │      118500.0 │         2185 │
│ javascript   │      117500.0 │         1504 │
│ pytorch      │      116896.0 │         1091 │
│ excel        │      116000.0 │         2315 │
│ tableau      │      115000.0 │         4402 │
│ sas          │      115000.0 │         1522 │
│ linux        │      115000.0 │         1731 │
│ jira         │      110650.0 │         1788 │
│ confluence   │      107500.0 │         1099 │
│ scikit-learn │      106500.0 │         1122 │
├──────────────┴───────────────┴──────────────┤
│ 49 rows (40 shown)                3 columns │
└─────────────────────────────────────────────┘
*/