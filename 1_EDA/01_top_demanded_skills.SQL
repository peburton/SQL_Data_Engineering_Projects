/*
Q: What are the most in-demand skills for data engineers?
Identify top 10 skills for data engineers
Focus on remote job postings
WHY?
    Retrieves the top 10 skills most in demand in the remote job market, providing insights into the most 
    valuable skills for job seekers
*/

SELECT
    sd.skills,
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
ORDER BY
    demand_count DESC
LIMIT 10;


/*
Here are the most in-demand skills for Data Engineers.
SQL and Python are by far the most in-demand skills, with around 29,000 job postings each - nearly double the next closest skill.
Cloud platforms round out the top skills, with AWS leading at ~18,000 postings, followed by Azure at ~14,000.
Apache Spark completes the top 5 with nearly 13,000 postings, highlighting the importance of big data processing skills.

- SQL and Python take a nearly even share of the skill list and remain foundational for professionals
    - These also overlap on most job postings
- AWS and Azure as massive cloud platforms that are seeing surges in use
- Big data tools like spark are highly valued
- Data pipeline tools (Airflow, Databricks, Snowflake) show growing demand
- Java and GCP round out the top ten
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
├────────────┴──────────────┤
│ 10 rows         2 columns │
*/