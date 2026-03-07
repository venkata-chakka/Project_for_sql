/*
What are the top demanding skills for business analysts?
-Identify the top 5 in-demand skills for a business analyst role.
-Focus on all job postings.
-Why? Retreives the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    count(skills_job_dim.job_id) as demand_count
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
    --AND salary_year_avg IS NOT NULL
    --AND job_location='Anywhere'
GROUP BY 
    skills
ORDER BY
    demand_count DESC
--LIMIT 10



/*

Here is a short summary of the insights:

1️⃣ Database and spreadsheet skills dominate demand
SQL and Microsoft Excel have the highest demand, showing that data querying and spreadsheet analysis are essential for most data roles.

2️⃣ Data visualization tools are highly requested
Tools like Tableau and Microsoft Power BI appear frequently, highlighting the importance of creating dashboards and visual reports for decision-making.

3️⃣ Programming skills support advanced analytics
Languages such as Python and R are widely required for deeper data analysis, automation, and statistical modeling.
*/