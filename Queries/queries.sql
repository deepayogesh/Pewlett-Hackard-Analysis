SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT count(first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility  born in 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT count(first_name)
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';  ---- 22857

-- Retirement eligibility  born in 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT count(first_name)
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';  ---- 23228

-- Retirement eligibility  born in 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

SELECT count(first_name)
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';  ---- 23104


-- Retirement eligibility  with two conditions for eligibilty
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT count(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');    --41380


---- create new table here  as retirement _info to sotore employee records
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

select * from  retirement_info;


select dept_no, first_name, last_name
from employees  as  e
join dept_manager as d on e.emp_no = d.emp_no
group by dept_no, first_name, last_name;

------
select dept_no, first_name, last_name
from employees  as  e
join dept_emp as d on e.emp_no = d.emp_no
group by dept_no, first_name, last_name;

--- before creating new table always make sure you drop it  and
-- if there constraints created DROP TABLE retirement_info CASCADE; 
DROP TABLE retirement_info; 

------------------------
--Recreate the retirement_info Table with the emp_no Column 
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

--inner join, also known as a simple join, will return matching data from two tables
-- Use the full outer join with caution!

-- Use Inner Join for Departments and dept-manager Tables
-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

--accurate retirement_info table needs this information :
-- 1. Employee number
-- 2. Employee name (first and last)
-- 3. If the person is presently employed with PH
-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    	retirement_info.first_name,
		retirement_info.last_name,
    	dept_emp.to_date
FROM 	retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

--  Use Aliases for Code Readability
select ri.emp_no,
		ri.first_name,
		ri.last_name,
		dm.to_date
from retirement_info as ri
left join dept_emp as dm 
on ri.emp_no =dm.emp_no;

--
--   create a new table to hold the information current_emp
--   new table containing only the 
--  current employees who are eligible for retirement will be returned
SELECT ri.emp_no,
    	ri.first_name,
    	ri.last_name,
		de.to_date
INTO 	current_emp
FROM 	retirement_info as ri
LEFT JOIN dept_emp as de
ON 		ri.emp_no = de.emp_no
WHERE  	de.to_date = ('9999-01-01');
--
--Use Count, Group By, and Order By
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM 		current_emp as ce
LEFT JOIN 	dept_emp as de
ON 			ce.emp_no = de.emp_no
GROUP BY 	de.dept_no;
--
--  Result of above query is not inany order 
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM 		 current_emp as ce
LEFT JOIN 	dept_emp as de
ON 			ce.emp_no = de.emp_no
GROUP BY 	de.dept_no
ORDER BY 	de.dept_no;
--
--  
-- Create new table wich gives the number of employees present in the department
drop table  count_of_emp_department;

-- new table from query 
SELECT COUNT(ce.emp_no), de.dept_no
INTO  count_of_emp_department
FROM 		 current_emp as ce
LEFT JOIN 	dept_emp as de
ON 			ce.emp_no = de.emp_no
GROUP BY 	de.dept_no
ORDER BY 	de.dept_no;


select * from  count_of_emp_department;

-- export this table to csv 
-- done using export wizard 

--   Create Additional Lists  of data
-- Employee Information: 
--		A list of employees containing their unique employee number, their last name, first name, gender, and salary
--  Management: 
--		A list of managers for each department, including the department number, name, and the manager's employee number, last name, first name, and the starting and ending employment dates
-- Department Retirees: 
--		An updated current_emp list that includes everything it currently has, but also the employee's departments

--   List 1: Employee Information

SELECT * FROM salaries
ORDER BY to_date DESC;

--  update our select statment and create new table of emp_info
-- This table is being created with joining 2 tables 


SELECT e.emp_no,
    	e.first_name,
		e.last_name,
    	e.gender,
    	s.salary,
    	de.to_date
INTO 	emp_info
FROM 	employees as e
INNER JOIN salaries as s
ON 		(e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON 		(e.emp_no = de.emp_no)
WHERE 	(e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');
--
--
-- List 2: Management
--  now we need data from Departments, Managers, and Employees tables and we are getting for 
-- filtered employee dat a
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- INTO manager_info
FROM 	dept_manager AS dm
INNER JOIN departments AS d
ON 		(dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON 		(dm.emp_no = ce.emp_no);

---  try by changing the join order 
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- INTO manager_info
FROM 	dept_manager AS dm
INNER JOIN current_emp AS ce
ON 		(dm.emp_no = ce.emp_no)
INNER JOIN departments AS d
ON 		(dm.dept_no = d.dept_no);

--   found no difference 
--  Create new Table for MAnagement information and export the data 
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO 	manager_info
FROM 	dept_manager AS dm
INNER JOIN departments AS d
ON 		(dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON 		(dm.emp_no = ce.emp_no);

select * from  manager_info;

--  List 3: Department information of Retirees

SELECT ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
INTO 	dept_info
FROM 	current_emp as ce
INNER JOIN dept_emp AS de
ON 		(ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON 		(de.dept_no = d.dept_no);
--
--
--  Create a Tailored List

select * from   dept_info;

select * 
from dept_info 
where dept_name ='Sales';

--  'Sales' 'Development'
select * 
from dept_info 
where dept_name IN ('Sales', 'Development') ;


	