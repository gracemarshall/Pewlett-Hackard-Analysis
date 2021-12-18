SELECT * FROM departments;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Count the Queries Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create New Tables
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Export Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO retire_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

SELECT * FROM departments

DROP TABLE dept_emp

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
	dept_no VARCHAR (4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM retirement_info

SELECT DISTINCT ON (emp_no) emp_no , first_name, last_name, 
			title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;	


SELECT employees.emp_no, employees.first_name, employees.last_name, 
			titles.title, titles.from_date, titles.to_date 
INTO retirement_titles
FROM employees
INNER JOIN titles
		ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT COUNT(emp_no) , title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

--Retiring Title
SELECT COUNT(emp_no) , title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;
		
SELECT DISTINCT ON (emp_no) emp_no , first_name, last_name, 
			title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;	

--Retirement_titles
SELECT employees.emp_no, employees.first_name, employees.last_name, 
			titles.title, titles.from_date, titles.to_date 
INTO retirement_titles
FROM employees
INNER JOIN titles
		ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (employees.emp_no)employees.emp_no, employees.first_name, employees.last_name, 
			employees.birth_date, dept_emp.from_date, dept_emp.to_date, titles.title
INTO mentorship_eligibilty
FROM employees
INNER JOIN dept_emp
		ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN titles
		ON (employees.emp_no = titles.emp_no)		
WHERE (dept_emp.to_date = ('9999-01-01')) 
AND (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;


SELECT * FROM unique_titles
