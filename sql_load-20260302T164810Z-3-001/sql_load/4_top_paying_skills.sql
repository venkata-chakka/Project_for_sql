/*
what are top paying skills?
-find top paying skills for business analysts.
-Look at the average salary for the business analyst roles.
-why? It reveals how each skill plays a role in salary levels for Business analysts
and helps identify the most financially rewarding skills to acquire.
*/

SELECT 
    skills,
    round( AVG(salary_year_avg)) as avg_salary
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON 
    skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Business Analyst'
    AND salary_year_avg is not null 
    AND job_location ='Anywhere'
GROUP BY 
    skills 
order BY 
    avg_salary DESC
LIMIT 25;
/*
Three insights

1️⃣ Cloud data platforms drive higher salaries ☁️
Skills related to cloud technologies like Google BigQuery, Snowflake, and Databricks appear among the highest-paying, showing strong demand for cloud-based data infrastructure expertise.

2️⃣ Machine learning frameworks increase earning potential 🤖
Tools such as TensorFlow and PyTorch are associated with high salaries, indicating that AI and machine learning skills are highly valued in advanced data roles.

3️⃣ Core data skills remain essential 📊
Fundamental tools like Python, R, and visualization tools like Tableau continue to be key skills required for well-paying data positions.

*/