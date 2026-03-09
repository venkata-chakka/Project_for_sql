/* What are the top paying Business analyst jobs?
    -Identify the top 10 highest paying Business Analyst jobs that are available remotly.
    -Focus on job postings with specified salaries (remove null values).
    -Why?  Highlight the most lucrative oppurtunities for Business Analysts in the remote job market.
*/


SELECT
    job_id,
    job_title,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg AS yearly_salary
FROM
    job_postings_fact
WHERE
    job_title_short = 'Business Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
