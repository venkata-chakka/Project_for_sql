# INTRODUCTION
The exploration aims to dive deep into the data job market, focusing specifically on Business Analyst and Data Analyst landscape-with my primary focus being the Business Analyst Landscape. The project is designed to uncover:

- Top-paying jobs in the current market.

- In-demand skills that employers are actively seeking.

- High-demand locations where salary levels are most competitive for data professionals.

The goal is to provide actionable insights for aspiring Business Analysts or those looking to pivot into the field, using data-driven evidence to identify the most lucrative and strategic career paths.

🔍 SQL queries? Check them out here: [Link to your project folder]
[PROJECT_FOR_SQL](/project_sql/)

# BACKGROUND
Driven by a desire to better understand the landscape of the data job market, this project focuses on uncovering the most strategic opportunities for Business Analysts. By analyzing real-world data, the goal is to identify which roles offer the highest compensation and which technical skills are currently most in-demand by employers.

The data for this analysis is sourced from [SQL COURSE](https://www.lukebarousse.com/sql), providing a rich foundation of information including job titles, salary benchmarks, and essential skill requirements.

The questions I wanted to answer through my SQL queries were:

1. **Top-Paying Roles:** What are the highest-paying Business Analyst positions currently available?

2. **Required Expertise:** What specific skills are necessary to secure these high-paying roles?

3. **Market Trends:** Which skills are most frequently requested across the broader Business Analyst job market?

4. **Salary Correlation:** Which specific skills are most strongly associated with higher salary brackets?

5. **Strategic Learning:** Based on the data, what are the most optimal skills to prioritize learning for career growth
# TOOLS USED
For my deep dive into the business analyst job market, I harnessed the power of several key tools to extract, manage, and share my findings.

 - **SQL**: The backbone of my entire analysis. I used SQL to query the database and unearth critical insights regarding job trends and salary benchmarks.

 - **postgreSQL**: My chosen database management system, providing a robust environment for handling and organizing the job posting data.

 - **VISUAL STUDIO**: My primary workspace for database management, where I wrote and executed all my SQL queries.

 - **GITHUB**: Essential for version control and transparency. 
These tools allowed me to share my SQL scripts and analysis while ensuring effective project tracking.

# ANALYSIS
### 1. TOP_PAYING_JOBS
What are the top paying Business analyst jobs?

    -Identify the top 10 highest paying Business Analyst jobs that offer remote work options.
    -Focus on job postings with specified salaries (remove null values).
    -Why?  Highlights the most lucrative oppurtunities for Business Analysts in the remote job market.
```SQL
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
```
Here's the breakdown of the top Business Analyst jobs in 2023:

- **Extensive Earning Potential:** Top 10 salaries range from $134,550 to $220,000, with the peak compensation reserved for leadership positions that bridge the gap between engineering and analytics.

- **Diverse Job Titles & Salary Variance:** The wide range of titles—from technical leadership like Lead BI Engineer ($220K) to specialized roles like Senior Economy Designer ($214K) and operational positions like Marketing Analytics Manager ($170K)—directly contributes to the broad salary spectrum ($134K–$220K), reflecting varied roles and specializations within Business Analyst landscape.


### 2. TOP_PAYING_JOB_SKILLS
What skills are required for the top paying jobs?
- Use top paying Business Analyst jobs from first query.
- Add the specific skills required for these roles.
- Why? It provides a detailed look at which high-paying jobs demand 
  certain skills, helping job seekers understand which skills to develop that align with top salaries.

 
``` SQL
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
    job_title_short = 'Business Analyst' AND
    job_location='Anywhere' AND
    salary_year_avg is not null
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
--LIMIT 25;
```
Here is the breakdown of the most demanded skills for top 25 highest paying jobs in 2023:
- **SQL and python** are the leaders with count of 4.
- **Excel + Tableau** follows closely after with count of 3.Other skills like **Looker, R, BigQuery e.t.c.,** show varying degrees of demand.

![TOP_SKILLS](/assets/Top%2010%20skills%20bar%20ch.png)
*Created this visualization using copilot of most demanded skills for top 25 highest paying jobs.*

I investigated a bit deeper to understand most demanded skills overall by exploring all the remote Business Analyst jobs and here is the breakdown.

**SQL** is the clear leader with a bold count of 66, nearly doubling the demand for the next most popular tools like **Excel and Tableau**. The results indicate that while a diverse toolkit including **Python and Power BI** is valuable, mastering the core **"Big Four" (SQL, Excel, Tableau, and Python)** provides the most comprehensive market coverage for a 
Business Analyst.


Skill            | Count
-----------------|-------
SQL              | 66
Excel            | 38
Tableau          | 36
Python           | 33
Power BI         | 15
R                | 11
SAS              | 11
Oracle           | 9
Flow             | 9
PowerPoint       | 8
*Table for top paying job skills.*

### 3.TOP_DEMANDING_SKILLS
What are the top demanding skills for business analysts?

-Identify the top 5 in-demand skills for a business analyst role.
-Focus on all job postings.

-Why? Retreives the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers.

```
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
LIMIT 5;
```


Here's the breakdown of the  most demanded skills for Business Analysts:

- **SQL and Excel** have the highest demand, showing that data querying and spreadsheet analysis are essential for most data roles.

- Tools like **Tableau and Power BI** appear frequently, highlighting the importance of creating dashboards and visual reports for decision-making.

- **Python** is also highly sought after, providing a competitive edge for Business Analysts.  


Skill            | Count
-----------------|-------
SQL              | 17,372
Excel            | 17,134
Tableau          | 9,324
Power BI         | 9,251
Python           | 8,097
*Table of the top 5 demandng skills for Business Analyst job postings.*

### 4.TOP_PAYING_SKILLS

what are top paying skills?

-find top paying skills for business analysts.
-Look at the average salary for the business analyst roles.

-why? It reveals how each skill plays a role in salary levels for Business analysts and helps identify the most financially rewarding skills to acquire.

```
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
```
Here's a breakdown of the results for top paying skills for Business Analysts:

- **Specialized cloud, database, and big‑data tools** such as Phoenix, MongoDB, BigQuery, GCP, Snowflake, Hadoop, Databricks lead the highest‑value skill group.
- **Machine learning frameworks** like TensorFlow, PyTorch, MXNet, Chainer form a strong cluster of in‑demand technical skills.
- **Core analytics and BI essentials** — Python, R, Tableau, Looker, Visio remain consistently important across advanced roles.

Skill            | Avg Salary
-----------------|------------
chef             | 220000
phoenix          | 135990
looker           | 130400
mongodb          | 120000
python           | 116516
bigquery         | 115833
gcp              | 115833
r                | 114629
snowflake        | 114500
db2              | 114500

*Table of the average salary for the top 10 paying skills for Business Analysts.*

### 5.OPTIMAL_SKILLS_TO_LEARN

What are the Optimal skills to learn for Business Analysts.

-Identify skils on high demand and associated with high average salary for Business Analysts.

-Why? Targets skills that offer job security and financial benefits offering strategic insights for career development in Business Analytics.

```
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
HAVING
     count(skills_job_dim.job_id)> 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
--LIMIT 25;
```
Here's the breakdown of the optimal skills for Business Analysts:

- **Python, SQL, Excel, and Tableau**, offering the strongest balance of high demand and strong pay — these form the core, high‑ROI analytics stack.

- **R, SAS, and Oracle** provide strong pay for niche or specialized roles, making them valuable add‑ons for boosting earning potential in traditional analytics, finance, and enterprise environments.

- **Power BI and Flow** show growing relevance in BI automation, offering good demand and solid pay for roles focused on dashboards, reporting, and workflow optimization.

# WHAT I

- **🧩 Advanced SQL Mastery:** I leveled up my query crafting by mastering complex JOINS and integrating multiple tables. I also harnessed WITH clauses (CTEs) to perform advanced "temp table" maneuvers, allowing me to organize complex logic into readable, modular blocks.

- **📊 Data Aggregation Expert:** I became proficient with Data Aggregation by using GROUP BY and aggregate functions (like COUNT() and AVG()) to transform thousands of rows of raw data into high-level business summaries.

- **💼 Real-World Project Execution:** I completed a full-scale project from scratch. I learned how to transform raw data into actionable results that can be used to drive real-life business decisions.

- **🛠️ Professional Tooling:** I moved beyond basic editors and got hands-on experience with PostgreSQL for database management and Visual Studio Code for professional-grade development.

- **📈 Analytical Thinking:** I improved my ability to turn vague business questions into precise, insightful SQL queries, ensuring the data I extracted actually solved a specific problem.

# CONCLUSIONS
### INSIGHTS
1. **Top paying Business Analyst Jobs**- The highest-paying remote jobs for Business Analysts offer a wide range of salaries, peaking at $220,000.

2. **Skills for top paying jobs**- SQL emerges as a high‑paying skill, consistently appearing in roles that offer strong compensation due to its foundational importance in data work.

3. **Most Demanding skills**- SQL is also the most demanded skill, making it the most valuable for job seekers.

4. **Top paying skills**- Skills with higher pay include Python, R, Tableau, Oracle, and SQL, showing that both programming and BI tools contribute significantly to higher‑earning opportunities.

5. **Optimal skills** — Python, SQL, Excel, and Tableau — offer the best balance of high demand and strong pay, forming the core stack for analytics and BI roles.

### CLOSING THOUGHTS
This project has enhanced my technical proficiency and analytical mindset necessary to transform complex data into actionable results, allowing me to navigate the Business Analyst job market with a clear, data-backed strategy for long-term growth.These findings give an aspiring Business Analyst a clear roadmap for where to focus their learning and effort.



