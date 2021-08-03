-- Use Employee table 

SELECT 	emp_no, 
		first_name, 
		last_name
FROM employees;
--	
SELECT 	title,
		from_date,
		to_date
FROM 	titles;
--
--
drop table retirement_titles;
--
SELECT * from retirement_titles; 
--
-- 1 to 5- Create table for retirement Titles 
SELECT 	em.emp_no, 
		em.first_name, 
		em.last_name,
		tlt.title,
		tlt.from_date,
		tlt.to_date
INTO  retirement_titles
FROM 	employees as em 
INNER JOIN titles as tlt
ON		(em.emp_no = tlt.emp_no)
WHERE 	(em.birth_date between '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no;   --133776 records


-- Now we have new table has Retirement Title data
--export the new table data into csv 

select count(*) from retirement_titles;   -- 133776

select * from retirement_titles;

-- 8, 9 Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)emp_no
			first_name,
			last_name,
			title
INTO clean_retirement_titles
FROM retirement_titles as rt 
ORDER BY emp_no,first_name DESC;
--
select count(*) from  clean_retirement_titles;  --90398

select * from clean_retirement_titles;

select * from titles;
--
--
--retrieve the number of employees by their most recent job title who
-- del 1- step  15 
select cmp.emp_no, 
		cmp.first_name, 
		cmp.last_name,
		tlt.title,
		tlt.from_date,
		tlt.to_date
from current_emp as cmp
join titles as tlt
on cmp.emp_no =tlt.emp_no
where cmp.emp_no = 10004
order by cmp.emp_no,tlt.from_date DESC;   -- emp_no = 10004 has 2 records we want current
--
--
select distinct on (cmp.emp_no)cmp.emp_no, 
		cmp.first_name, 
		cmp.last_name,
		tlt.title,
		tlt.from_date
from current_emp as cmp
join titles as tlt
on cmp.emp_no =tlt.emp_no
where cmp.emp_no = 10004
order by cmp.emp_no,tlt.from_date DESC;  -- tried with reccord of  emp_no = 10004

select distinct on (cmp.emp_no)cmp.emp_no, 
		cmp.first_name, 
		cmp.last_name,
		tlt.title,
		tlt.from_date
from current_emp as cmp
join titles as tlt
on cmp.emp_no =tlt.emp_no
where cmp.emp_no = 10004
order by cmp.emp_no,tlt.from_date;  -- tried with reccord of  emp_no = 10004
--- distict on always catches the first appearance of the record in table . 
-- using order with no preferenc is always Asecnding 
-- by giving  DESC on column from_date will give the results with latest first

select distinct on (cmp.emp_no)cmp.emp_no, 
		cmp.first_name, 
		cmp.last_name,
		tlt.title,
		tlt.from_date,
		tlt.to_date
from current_emp as cmp
join titles as tlt
on cmp.emp_no =tlt.emp_no
where cmp.emp_no = 10004
order by cmp.emp_no,tlt.from_date DESC;  -- tried with reccord of  emp_no = 10004
--
-- 15.  retrieve the number of employees by their most recent job title who are about to retire.
select distinct on (cmp.emp_no)cmp.emp_no, 
		cmp.first_name, 
		cmp.last_name,
		tlt.title,
		tlt.from_date
from current_emp as cmp
join titles as tlt
on cmp.emp_no =tlt.emp_no
where tlt.to_date = '9999-01-01'  -- Recent job title title 
order by cmp.emp_no,tlt.from_date DESC;  

--
--
select distinct on (rt.emp_no)rt.emp_no, 
		rt.first_name, 
		rt.last_name,
		rt.title,
		tlt.from_date
from retirement_titles rt    ---from current_emp as cmp
join titles as tlt
on rt.emp_no =tlt.emp_no
order by rt.emp_no,tlt.from_date DESC;
-----
--
-- drop table unique_titles ;

select * from unique_titles;
---13. Create table unique titles
select DISTINCT ON (emp_no)emp_no ,
				first_name,
				last_name,
				title
into unique_titles 
from retirement_titles as rt
Order by emp_no, to_date DESC; 
--
-- 19.  REtiring titles table 
select count(title)Total_count , title
from unique_titles
group by title
order by count(title) DESC;
--- 
--drop table  retiring_titles;
--
-- 20 . create  retiring titles table 
select count(title), title
into retiring_titles 
from unique_titles
group by title
order by count(title) DESC;
--
select * from retiring_titles;
--------------------------------------------------------------------------
-- Deliverable 2 
--  Build the query in steps
SELECT em.emp_no, 
		em.first_name,
		em.last_name,
		em.birth_date,
		dt.from_date,
		dt.to_date
--INTO   
FROM  employees  AS em 
JOIN dept_emp  AS dt
ON  em.emp_no = dt.emp_no
--WHERE em.birth_date between '1965-01-01' and '1965-12-31'
ORDER BY em.emp_no;  --  rows 
--

----
SELECT distinct on(em.emp_no)em.emp_no,     -- choose one latest from duplicate records
		em.first_name,
		em.last_name,
		em.birth_date,
		dt.from_date,
		dt.to_date,
		tlt.title
--INTO   
FROM  	employees  AS em 
JOIN 	dept_emp  AS dt 
ON  	em.emp_no = dt.emp_no 
JOIN 	titles as tlt
ON 		em.emp_no = tlt.emp_no
WHERE 	(em.birth_date between '1965-01-01' and '1965-12-31')   --- Birthday range
AND   	(dt.to_date = ('9999-01-01'))   --- Current employees 
ORDER BY em.emp_no;  --  


-- --
-- now get titles 
SELECT  distinct on(em.emp_no)em.emp_no,     -- choose one latest from duplicate records
		em.first_name,
		em.last_name,
		em.birth_date,
		dt.from_date,
		dt.to_date,
		tlt.title
--INTO   
FROM  employees  AS em 
JOIN dept_emp  AS dt 
ON  em.emp_no = dt.emp_no 
JOIN titles as tlt
ON em.emp_no = tlt.emp_no
WHERE (em.birth_date between '1965-01-01' and '1965-12-31')   --- Birthday range
AND   (dt.to_date = ('9999-01-01'))   --- Current employees 
ORDER BY em.emp_no;  --  
--  
-- Before creating delete table and create new 
drop table mentorship_eligibility;
--
SELECT distinct on(em.emp_no)em.emp_no,     -- choose one latest from duplicate records
		em.first_name,
		em.last_name,
		em.birth_date,
		dt.from_date,
		dt.to_date,
		tlt.title
INTO   mentorship_eligibility
FROM  employees  AS em 
JOIN dept_emp  AS dt 
ON  em.emp_no = dt.emp_no 
JOIN titles as tlt
ON em.emp_no = tlt.emp_no
WHERE (em.birth_date between '1965-01-01' and '1965-12-31')   --- Birthday range
AND   (dt.to_date = ('9999-01-01'))   --- Current employees 
ORDER BY em.emp_no;  --  
--
--
select * from mentorship_eligibility;
--
select * from mentorship_eligibility where emp_no = 10095;
--
-----------------------------------------------------------------------------
-- to check the result chosse to date from title table ass well, 
SELECT distinct on(em.emp_no)em.emp_no,     --   distinct on(em.emp_no)  choose one latest from duplicate records
		em.first_name,
		em.last_name,
		em.birth_date,
		dt.from_date,
		dt.to_date,
		tlt.title, 
		tlt.to_date as title_date
--INTO   
FROM  	employees  AS em 
JOIN 	dept_emp  AS dt 
ON  	em.emp_no = dt.emp_no 
JOIN 	titles as tlt
ON 		em.emp_no = tlt.emp_no
WHERE  (em.birth_date between '1965-01-01' and '1965-12-31')   --- Birthday range
AND    (dt.to_date = ('9999-01-01')) 
and 	em.emp_no = 10095 --10031 --10122-- 10095   -- distinct on(em.emp_no)--- Current employees 
ORDER BY em.emp_no;  --  


---  tried to find out with one record what is happening 
select distinct on (em.emp_no)em.emp_no,
		em.first_name,
		em.last_name,
		em.birth_date, 
 		tlt.title,
 		dt.to_date
from  	employees  as em
join  	titles as tlt
On    	em.emp_no = tlt.emp_no 
JOIN  	dept_emp  AS dt 
ON    	em.emp_no = dt.emp_no 
WHERE 	(em.birth_date between '1965-01-01' and '1965-12-31')   --- Birthday range
AND   	(dt.to_date = ('9999-01-01')) 
and   	em.emp_no = 10095 
order by em.emp_no ; 443308 rows 
---- 
-- this result shows the record of senior staff 
-- for this employee Staff  title records is the curent title of this employee. 
-- 
select count(*) from employees;    --300024 
select * from employees;

select * from retirement_titles order by emp_no;

select count(*) from  retirement_info; --41380

select * from retirement_info;  -- 41380 rows

select count(*) from current_emp; -- 33118 employees 


