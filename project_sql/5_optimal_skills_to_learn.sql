/*
optimal skills to learn for Business Analysts.
- Identify skils on high demand and associated with hogh average salary for Business Analysts.
-Why? Targets skills that offer job security and finncial benefits offering 
strategic insights for career development in Business Analytics.
*/

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count,
    round( avg(job_postings_fact.salary_year_avg)) AS avg_salary
FROM    
    job_postings_fact
INNER JOIN 
    skills_job_dim ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON 
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Business Analyst' 
    AND job_work_from_home =True
    and salary_year_avg is not null
GROUP BY skills_dim.skill_id
having 
     count(skills_job_dim.job_id)> 5
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 10;

