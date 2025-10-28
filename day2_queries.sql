USE mthree_db1;

-- Get all employees with all columns

SELECT * FROM emp;

-- Get specific columns

SELECT
	ename
    ,job
    ,deptno
FROM emp;

-- Get distinct job titles

SELECT
	DISTINCT(job) AS Distinct_job_titles
FROM emp;

-- Employees with salary > 2000

SELECT *
FROM emp
WHERE sal > 2000;

-- Employees hired after 1981

SELECT *
FROM emp
WHERE YEAR(hiredate) > 1981;

-- Top 5 highest paid employees

SELECT *
FROM emp
ORDER BY sal DESC
LIMIT 5;

-- Get all dept info with all columns

SELECT * FROM dept;

-- Average salary by department

SELECT
	deptno
	,ROUND(AVG(sal),0) AS avg_salary
FROM emp
GROUP BY deptno;

-- Average salary by department, with names

SELECT
	e.deptno AS dept_no
    ,d.dname AS dept_name
	,ROUND(AVG(e.sal),0) AS avg_salary
FROM emp AS e
LEFT JOIN dept AS d
USING(deptno)
GROUP BY e.deptno, d.dname;

-- Number of employees per job type

SELECT
	job
	,COUNT(*) AS nb_employees
FROM emp
GROUP BY job;

-- Highest, lowest, and average salary

SELECT
	ROUND(MAX(sal),0) AS highest_salary
    ,ROUND(MIN(sal),0) AS lowest_salary
	,ROUND(AVG(sal),0) AS average_salary
FROM emp;

-- Employees hired by year

SELECT
	YEAR(hiredate) AS year
	,COUNT(*) AS nb_employees
FROM emp
GROUP BY YEAR(hiredate);

-- Fetch the top 3 employees in each department earning the max salary

SELECT
	*
FROM (
	SELECT
    e.*
    ,d.dname AS dept_name
    ,RANK() OVER (PARTITION BY e.deptno ORDER BY e.sal DESC) AS rank_no
    FROM emp AS e
    LEFT JOIN dept AS d
    USING(deptno)
) AS ranked
WHERE rank_no < 4;

-- Fetch first 2 employees from each department who joined the company

SELECT
	*
FROM (
	SELECT
    e.*
    ,d.dname AS dept_name
    ,RANK() OVER (PARTITION BY e.deptno ORDER BY e.hiredate ASC) AS rank_no
    FROM emp AS e
    LEFT JOIN dept AS d
    USING(deptno)
) AS ranked
WHERE rank_no < 3;



