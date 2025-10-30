CREATE database mthree_students;

USE mthree_students;

DROP TABLE IF EXISTS cohort;

CREATE TABLE cohort (
cohort_ID CHAR(6) NOT NULL PRIMARY KEY,
start_date DATE NOT NULL
);

-- students parent is cohort

DROP TABLE IF EXISTS students;

CREATE TABLE students (
student_ID INT NOT NULL PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
email VARCHAR(40) NOT NULL,
cohort_ID CHAR(6) default NULL,
FOREIGN KEY fk_students_cohort (cohort_ID)
	REFERENCES cohort(cohort_ID)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

-- realised later that I want to remove the ON DELETE SET NULL constraint
-- firstly check what name of foreign key is saved as and drop to remove, before adding a new one

ALTER TABLE students
DROP FOREIGN KEY students_ibfk_1;

ALTER TABLE students
ADD CONSTRAINT fk_students_cohort
FOREIGN KEY (cohort_ID)
    REFERENCES cohort(cohort_ID)
    ON UPDATE CASCADE;

DROP TABLE IF EXISTS recruiter;

CREATE TABLE recruiter (
recruiter_ID INT NOT NULL PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
email VARCHAR(40) NOT NULL
);

-- recruitments parents are recruiter and students

DROP TABLE IF EXISTS recruitments;

CREATE TABLE recruitments (
recruitment_ID INT NOT NULL PRIMARY KEY,
recruiter_ID INT NOT NULL,
student_ID INT NOT NULL,
recruitment_date DATE default NULL,
FOREIGN KEY fk_recruitments_recruiter (recruiter_ID)
	REFERENCES recruiter(recruiter_ID)
    ON UPDATE CASCADE,
FOREIGN KEY fk_recruitments_students (student_ID)
	REFERENCES students(student_ID)
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS modules;

CREATE TABLE modules (
module_ID INT NOT NULL PRIMARY KEY,
module_name VARCHAR(40) default NULL
);

-- students_per_modules parents are modules and students

DROP TABLE IF EXISTS students_per_modules;

CREATE TABLE students_per_modules (
students_per_module_ID INT NOT NULL PRIMARY KEY,
module_ID INT NOT NULL,
student_ID INT NOT NULL,
FOREIGN KEY fk_students_per_modules_modules (module_ID)
	REFERENCES modules(module_ID)
    ON UPDATE CASCADE,
FOREIGN KEY fk_students_per_modules_students (student_ID)
	REFERENCES students(student_ID)
    ON UPDATE CASCADE
);

-- assessments parent is modules

DROP TABLE IF EXISTS assessments;

CREATE TABLE assessments (
assessment_ID INT NOT NULL PRIMARY KEY,
assessment_name VARCHAR(40) default NULL,
module_ID INT NOT NULL,
FOREIGN KEY fk_assessments_modules (module_ID)
	REFERENCES modules(module_ID)
    ON UPDATE CASCADE
);

-- assessment_results parents are assessments and students

DROP TABLE IF EXISTS assessment_results;

CREATE TABLE assessment_results (
assessment_result_ID INT NOT NULL PRIMARY KEY,
assessment_ID INT NOT NULL,
student_ID INT NOT NULL,
result DECIMAL(4,3) default NULL,
FOREIGN KEY fk_assessment_results_assessments (assessment_ID)
	REFERENCES assessments(assessment_ID)
    ON UPDATE CASCADE,
FOREIGN KEY fk_assessment_results_students (student_ID)
	REFERENCES students(student_ID)
    ON UPDATE CASCADE
);

-- inserting values into tables

INSERT INTO recruiter(recruiter_ID, first_name, last_name, email) VALUES
	(1, 'Olivia', 'Chen', 'olivia.chen@example.com'),
    (2, 'Marcus', 'Patel', 'marcus.patel@example.com'),
    (3, 'Sophia', 'Nguyen', 'sophia.nguyen@example.com'),
    (4, 'Ethan', 'Romero', 'ethan.romero@example.com'),
    (5, 'Hannah', 'Brooks', 'hannah.brooks@example.com');

INSERT INTO cohort(cohort_ID, start_date) VALUES
	('C433', '2025-09-01'),
    ('C434', '2025-11-01'),
    ('C435', '2026-01-01'),
    ('C436', '2026-03-01'),
    ('C437', '2026-05-01');

INSERT INTO students(student_ID, first_name, last_name, email, cohort_ID) VALUES
	(1, 'Liam', 'Anderson', 'liam.anderson@example.com', 'C433'),
	(2, 'Isabella', 'Garcia', 'isabella.garcia@example.com', 'C433'),
	(3, 'Noah', 'Khan', 'noah.khan@example.com', 'C434'),
	(4, 'Ava', 'Thompson', 'ava.thompson@example.com', 'C433'),
	(5, 'Lucas', 'Martinez', 'lucas.martinez@example.com', 'C433');

INSERT INTO recruitments(recruitment_ID, recruiter_ID, student_ID, recruitment_date) VALUES
	(1, 1, 1, '2025-08-10'),
	(2, 1, 2, '2025-08-15'),
	(3, 1, 3, '2025-08-16'),
	(4, 2, 4, '2025-08-11'),
	(5, 3, 5, '2025-08-13');

INSERT INTO modules(module_ID, module_name) VALUES
	(1, 'Financial Concepts'),
	(2, 'IT Foundations'),
	(3, 'Python'),
	(4, 'SQL'),
	(5, 'React');

INSERT INTO students_per_modules(students_per_module_ID, module_ID, student_ID) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 1, 3),
	(4, 1, 4),
	(5, 1, 5),
    (6, 2, 1),
    (7, 2, 2),
    (8, 2, 4),
    (9, 2, 5),
    (10, 3, 1),
    (11, 3, 2),
    (12, 3, 4),
    (13, 3, 5),
    (14, 4, 1),
    (15, 4, 2),
    (16, 4, 4),
	(17, 4, 5);
    
INSERT INTO assessments(assessment_ID, assessment_name, module_ID) VALUES
	(1, 'Financial Markets', 1),
	(2, 'IT Foundations', 2),
	(3, 'Python Basics', 3),
	(4, 'SQL Basics', 4),
	(5, 'React Quiz', 5);

INSERT INTO assessment_results(assessment_result_ID, assessment_ID, student_ID, result) VALUES
	(1, 1, 1, 0.920),
	(2, 1, 2, 0.855),
	(3, 1, 4, 0.820),
	(4, 1, 5, 0.910),
	(5, 2, 1, 0.730),
    (6, 2, 2, 0.560),
    (7, 2, 4, 0.925),
    (8, 2, 5, 0.870),
    (9, 3, 1, 0.420),
    (10, 3, 2, 0.530),
    (11, 3, 4, 0.820),
    (12, 3, 5, 0.650);


