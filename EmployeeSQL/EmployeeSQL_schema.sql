 -- Create tables for each db/file 
 -- If needed run  this dropouts to start from zero:
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;

 -- 1. create table 'departments' 
CREATE TABLE departments(
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (dept_no)
);

--2. create table 'titles' 
CREATE TABLE titles(
	title_id VARCHAR(5) NOT NULL,
	title VARCHAR(50) NOT NULL,
	PRIMARY KEY (title_id)
);

-- 3. create table 'employees'
CREATE TABLE employees(
	emp_no INT NOT NULL, 				--PK
	emp_title VARCHAR(5) NOT NULL, 		--FK >- titles.title_id
	birth_date DATE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex VARCHAR(1) NOT NULL,			--F/M only
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);
	
--4. create table 'salaries'	
CREATE TABLE salaries(
	emp_no INT NOT NULL, 	--FK - employees.emp_no
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no)		-- CHECK IF POSSIBLE: PK=FK for this table as it is defined as One-To-One relationship
);

--5.create junction table 'dept_manager'
CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,		--FK >- departments.dept_no
	emp_no INT NOT NULL,				--FK >- employees.emp_no
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),		-->>> SHOULD WE CREATE COMPOSITE PRIMARY KEY???
	PRIMARY KEY (dept_no, emp_no)
);

--6.create table 'dept_emp'
CREATE TABLE dept_emp(
	emp_no INT NOT NULL, 			-- FK >- employees.emp_no
	dept_no VARCHAR(4) NOT NULL, 	-- FK >- departments.dept_no
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMAry KEY (emp_no, dept_no)
);

-- 7. run the tables to be sure they are created correctly, import databaases and run tables again
SELECT * FROM departments;
SELECT * FROM titles;
SELECT * FROM employees LIMIT(100);
SELECT * FROM salaries LIMIT(100);
SELECT * FROM dept_manager;
SELECT * FROM dept_emp LIMIT(100);