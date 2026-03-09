/*
What skills are required for the top paying jobs?
- Use top paying Business Analyst jobs from first query.
- Add the specific skills required for these roles.
- Why? It provides a detailed look at which high-paying jobs demand 
  certain skills, helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_job_skills AS(
    
SELECT
    job_id,
    job_title,
    salary_year_avg AS yearly_salary,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN 
    company_dim ON
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Business Analyst' 
    AND job_location='Anywhere' 
    AND salary_year_avg is not null
ORDER BY 
    salary_year_avg DESC
)

SELECT 
    top_paying_job_skills.*,
    skills
FROM 
    top_paying_job_skills
INNER JOIN 
    skills_job_dim ON 
    top_paying_job_skills.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON 
    skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    yearly_salary DESC
LIMIT 25;

/*
- SQL is the clear leader — nearly every job requires it.
- Excel + Tableau form the core BI toolkit.
- Python is the differentiator for higher-paying roles.
- Power BI is strong across finance, healthcare, and enterprise roles.

SQL        ███████████████████████████████████████████████████████████████████████████████  72
Excel      ████████████████████████████████████████████  48
Tableau    ████████████████████████████████████  44
Python     ████████████████████████  32
Power BI   ████████████  18

*/