-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no = s.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE 
	hire_date >= '1986/01/01' AND
	hire_date <= '1986/12/31';

	-- just a check how many employees in totoal were hired in 1986
SELECT COUNT(hire_date) AS "Total employees hired in 1986"
FROM employees
WHERE
	hire_date >= '1986/01/01' AND
	hire_date <= '1986/12/31';
	
-- 3. List the manager of each department with the following information: department number, department name, 
-- the manager's employee number, last name, first name.
SELECT d_m.dept_no, d.dept_name, d_m.emp_no, e.last_name, e.first_name
FROM dept_manager AS d_m
	JOIN departments AS d 
	ON (d_m.dept_no = d.dept_no)
		JOIN employees AS e
		ON (d_m.emp_no = e.emp_no);

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
	-- creating a view and then show results (we use view later to simplify queries - alternative)
DROP VIEW IF EXISTS empl_dept_assign;

CREATE VIEW empl_dept_assign AS 
SELECT d_e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS d_e
	JOIN employees AS e
	ON (d_e.emp_no = e.emp_no)
		JOIN departments AS d
		ON (d_e.dept_no = d.dept_no);

SELECT * FROM empl_dept_assign;

	-- check if all employees were included in the query:
SELECT COUNT(DISTINCT(emp_no)) AS "Total Employees" FROM empl_dept_assign;
		
-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex FROM employees
WHERE 
	first_name = 'Hercules' AND
	last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT * FROM empl_dept_assign
WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT * FROM empl_dept_assign
WHERE 	
	dept_name = 'Sales' OR 
	dept_name = 'Development';

	-- just employee per dept count for info
SELECT dept_name, COUNT(emp_no) AS "Number of Employees"
FROM empl_dept_assign
WHERE 	
	dept_name = 'Sales' OR 
	dept_name = 'Development'
GROUP BY dept_name;

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(emp_no) AS "count"
FROM employees
GROUP BY last_name
ORDER BY "count" DESC;