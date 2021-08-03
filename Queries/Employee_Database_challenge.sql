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
-- Create table for retirement Titles 
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

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)emp_no
			first_name,
			last_name,
			title
INTO clean_retirement_titles
FROM retirement_titles as rt 
ORDER BY emp_no,first_name DESC;
--
select count(*) from  clean_retirement_titles;  --90398

select * from titles;
--
--
select count(title) from  unique_titles;  -- 90398
--
--retrieve the number of employees by their most recent job title who
-- del 1- step  15 
select cmp.emp_no, 
		cmp.first_name, 
		cmp.last_name,
		tlt.title,
		tlt.from_date
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
--where cmp.emp_no = 10004
order by cmp.emp_no,tlt.from_date DESC;  -- tried with reccord of  emp_no = 10004

select distinct on (rt.emp_no)rt.emp_no, 
		rt.first_name, 
		rt.last_name,
		rt.title,
		tlt.from_date
from retirement_titles rt    ---from current_emp as cmp
join titles as tlt
on rt.emp_no =tlt.emp_no
--where cmp.emp_no = 10004
order by rt.emp_no,tlt.from_date DESC;

select distinct on (rt.emp_no)rt.emp_no, 
		rt.first_name, 
		rt.last_name,
		rt.title,
		tlt.from_date
from retirement_titles rt    ---from current_emp as cmp
join titles as tlt
on rt.emp_no =tlt.emp_no
--where cmp.emp_no = 10004
order by rt.emp_no,tlt.from_date DESC;
-----
--
-- drop table unique_titles ;

select * from unique_titles;
--- unique titles
select DISTINCT ON (emp_no)emp_no ,
				first_name,
				last_name,
				title
into unique_titles 
from retirement_titles as rt
Order by emp_no, to_date DESC; 
--- 
-------------------------------------
-- Deliverable 2 
--
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
WHERE em.birth_date between '1965-01-01' and '1965-12-31'
ORDER BY em.emp_no;  -- returns 2131 rows 
--
SELECT em.emp_no, 
		em.first_name,
		em.last_name,
		em.birth_date
	  	--dt.from_date,
		--dt.to_date,
		--tlt.title,
--INTO   
FROM  employees  AS em 
JOIN dept_emp  AS dt
ON  em.emp_no = dt.emp_no
WHERE em.birth_date between '1965-01-01' and '1965-12-31'
ORDER BY em.emp_no;  -- returns 2131 rows 
--
--drop table mentorship_eligibility;
--
SELECT distinct on (em.emp_no)em.emp_no, 
		em.first_name,
		em.last_name,
		em.birth_date
	  	--dt.from_date,
		--dt.;to_date,
		--tlt.title,
INTO  mentorship_eligibility   --- Mentorship Eligibility  
FROM  employees  AS em 
JOIN  dept_emp  AS dt
ON    em.emp_no = dt.emp_no
WHERE em.birth_date between '1965-01-01' and '1965-12-31'
ORDER BY em.emp_no;  -- returns 2131 rows 




-- Tried these for the result are correct or not 
select me.emp_no, 
		me.first_name,
		me.last_name,
		me.birth_date,
		tlt.title
FROM   mentorship_eligibility  AS me
JOIN   titles as tlt
ON	 	me.emp_no = tlt.emp_no
where me.emp_no = 10095
ORDER BY me.emp_no;

select DISTINCT ON (me.emp_no)me.emp_no, 
		me.first_name,
		me.last_name,
		me.birth_date,
		tlt.title
FROM   mentorship_eligibility  AS me
JOIN   titles as tlt
ON	 	me.emp_no = tlt.emp_no
where me.emp_no = 10095 
ORDER BY me.emp_no;
---  why disticnt chose Senier staff as result because the distict on column of empno 


select DISTINCT ON (me.emp_no)me.emp_no, 
		me.first_name,
		me.last_name,
		me.birth_date,
		tlt.title
FROM   mentorship_eligibility  AS me
JOIN   titles as tlt
ON	 	me.emp_no = tlt.emp_no
--where me.emp_no = 10095 
ORDER BY me.emp_no;








-- 
