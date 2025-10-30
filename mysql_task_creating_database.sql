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



