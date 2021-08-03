# Pewlett-Hackard-Analysis
## Goal of the project was to find number of employees who are retiring. List of employees who are eligible to be mentorship program. 
## Summary 
### 1.Number of Retiring Employees by Title
a. Employees whose birthday falls in the date range of January 1, 1952 and December 31, 1955 are Retiring. 
b. Employees records stores their birthday. I filtered out the employees records whose birthday falls in retiring range and got the list of retiring employees. 
c. Next for these Retiring employees found the titles. The Employee Titles table contains title of employee and duration of that title. 
d. I observed that due to promotions some of the employees had more than one record in the Titles table. 
e. Stored the Retiring Titles table data for all retiring employees. 
When multiple title records were found only the latest title of the employee was selected.    

### 2. The Employees Eligible for the Mentorship Program
a. Employees who were born between January 1, 1965, and December 31, 1965, were eligible for the Mentorship Program. 
b. Created new table to hold the employees whose birthdays falls in the year 1965. 
c. Then got the department and latest title information of these employees. 
d. As I observed multiple entries of the employee in the Titles table.
Only one latest record was selected to store in new table.
New table Mentorship Eligibility stores the information of the employee such as first name, last name, department, latest tile.
