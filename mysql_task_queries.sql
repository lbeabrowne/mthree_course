-- Checking all values in tables

SELECT * FROM assessment_results;
SELECT * FROM assessments;
SELECT * FROM cohort;
SELECT * FROM modules;
SELECT * FROM recruiter;
SELECT * FROM recruitments;
SELECT * FROM students;
SELECT * FROM students_per_modules;

-- What is the total number of students?

SELECT
	COUNT(*) AS total_nb_students
FROM students;

-- output: 5

-- Which module has the most students enrolled?

WITH enrolled AS(
SELECT
	module_ID
    ,COUNT(module_ID) AS nb_students
FROM students_per_modules
GROUP BY module_ID
ORDER BY 2 DESC
LIMIT 1
)
SELECT
    m.module_name
    ,e.nb_students
FROM enrolled AS e
LEFT JOIN modules AS m
USING(module_ID);

-- output: Financial Concepts with 5 students

-- Which is the biggest cohort?

SELECT
	cohort_ID
    ,COUNT(cohort_ID) AS nb_students
FROM students
GROUP BY cohort_ID
ORDER BY COUNT(cohort_ID) DESC
LIMIT 1;

-- output: C433 with 4 students

-- Which cohorts have at least 2 students?

SELECT
    cohort_ID
    ,COUNT(student_ID) AS nb_students
FROM students
GROUP BY cohort_ID
HAVING COUNT(student_ID) >= 2;

-- output: C433 with 4 students

-- What were the first three recruitments?

SELECT
	r.recruiter_ID
    ,n.first_name
    ,n.last_name
    ,r.student_ID
    ,s.first_name
    ,s.last_name
    ,r.recruitment_date
FROM recruitments AS r
LEFT JOIN recruiter AS n
USING(recruiter_ID)
LEFT JOIN students AS s
USING(student_ID)
ORDER BY recruitment_date ASC
LIMIT 3;

-- output: Olivia Chen recruited Liam Anderson on 2025-08-10
-- Marcus Patel recruited Ava Thompson on 2025-08-11
-- Sophia Nguyen recruited Lucas Martinez on 2025-08-13

-- Which recruiter recruited the most students?

WITH nb AS(
SELECT
	recruiter_ID
	,COUNT(recruiter_ID) AS nb_recruited
FROM recruitments
GROUP BY recruiter_ID
)
SELECT
	r.recruiter_ID
    ,r.first_name
    ,r.last_name
	,n.nb_recruited
FROM nb AS n
LEFT JOIN recruiter AS r
USING(recruiter_ID)
ORDER BY n.nb_recruited DESC
LIMIT 1;

-- output: Olivia Chen with 3 students

-- What is the average, min and max length of time between recruitment date and start date?

SELECT
    ROUND(AVG(DATEDIFF(c.start_date, r.recruitment_date)),0) AS avg_nb_days
    ,ROUND(MIN(DATEDIFF(c.start_date, r.recruitment_date)),0) AS min_nb_days
	,ROUND(MAX(DATEDIFF(c.start_date, r.recruitment_date)),0) AS max_nb_days
FROM recruitments AS r
LEFT JOIN students AS s
ON r.student_ID = s.student_ID
LEFT JOIN cohort AS c
ON s.cohort_ID = c.cohort_ID;

-- output: in days, avg: 31, min: 17, max: 77

-- What was the average score for each assessment?

WITH avg_score AS(
SELECT
	assessment_ID
	,ROUND((AVG(result)*100),1) AS `avg_result_(%)`
FROM assessment_results
GROUP BY assessment_ID
)
SELECT
	a.assessment_ID
    ,n.assessment_name
    ,a.`avg_result_(%)`
FROM avg_score AS a
LEFT JOIN assessments AS n
USING(assessment_ID);

-- output: Financial Markets: 87.6%
-- IT Foundations: 77.1%
-- Python Basics: 60.5%

-- Who got the top marks for each assessment?

SELECT
	*
FROM (
	SELECT
		a.assessment_ID
        ,n.assessment_name
        ,s.student_ID
        ,s.first_name
        ,s.last_name
        ,ROUND((a.result)*100,1) AS `result_(%)`
		,RANK() OVER (PARTITION BY a.assessment_ID ORDER BY a.result DESC) AS rank_no
    FROM assessment_results AS a
	LEFT JOIN students AS s
    ON a.student_ID = s.student_ID
    LEFT JOIN assessments AS n
    ON a.assessment_ID = n.assessment_ID
) AS ranked
WHERE rank_no = 1;

-- output: Financial Markets: Liam Anderson with 92% 
-- IT Foundations: Ava Thompson with 92.5% 
-- Python Basics: Ava Thompson with 82.0% 


-- Which recruiters recruited the students with the highest marks?

WITH avg_score AS(
SELECT
	student_ID
	,ROUND((AVG(result)*100),1) AS `avg_result_(%)`
FROM assessment_results
GROUP BY student_ID
),
joined AS(
SELECT
    n.recruiter_ID
    ,n.first_name
	,n.last_name
    ,a.`avg_result_(%)`
FROM avg_score AS a
RIGHT JOIN students AS s
USING(student_ID)
RIGHT JOIN recruitments AS r
USING(student_ID)
RIGHT JOIN recruiter AS n
USING(recruiter_ID)
)
SELECT
	recruiter_ID
    ,first_name
    ,last_name
    ,ROUND(AVG(`avg_result_(%)`),1) AS `avg_students_marks_(%)`
FROM joined
GROUP BY 1
ORDER BY 4 DESC;

-- output: recruiter who recruited students who got highest marks: Marcus Patel



