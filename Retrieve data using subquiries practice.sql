use hr;
select *from hr.departments;
select * from hr.employees;
-- /* Task 1:diplay the employees id ,firstname,lastname,department names of all empoyees using subquery*/
select employees.employee_id,employees.first_name,employees.last_name,
  (select departments.department_name from departments where departments.department_id = employees.department_id)as department_name
from employees;
-- interpretation: finally employee_id,first_name,last_name,department_name excueted in one table

-- display the first names,lastnames, and salaries of the empoyees whose salaries are greater than the average salary of all employees,grouped  by the department ids*/
select first_name,last_name,salary,department_id from employees where
  salary > (select avg(salary) from employees)
  order by department_id;
  -- finally we got 51 rows of whose salaries are greater than the avg salary of all employees.
  
/* Task3:display the firstname,lastname,of those employees of the sales department who have a salary < the avg salary of all employees of the sales department*/
select first_name,last_name from employees where employees.department_id in 
  (select department_id from departments where department_name like 'sales%' )
 and employees.salary < (select avg(employees.salary) from employees  where employees.department_id = employees.department_id );
 -- Interpretaion: here gives 4 rows salary < the avg salary of all employees of sales department with first_name , last_name
 
 /* task 4:display the firstname,lastname ,salaries of the employees who have a salary higher than the salaries of all it programmers.display the details of the employees in the ascending order of salary*/
 select max(salary) from employees where job_id = 'IT_PROG' ;
 select first_name, last_name,salary from employees where salary >
 (select max(salary) from employees where job_id = 'IT_PROG')
 order by salary asc;
 -- interpretation : finallay we got 23 rows for salary > max(salary) employees with first_name,last_name
 
 /*task5:display the records of the  employees with the minimum salary in the emloyees table, grouped by the job_id column and arranged in ascending order of salaries*/
select job_id, employee_id, first_name,last_name ,salary from employees where (job_id,salary) in
  (select job_id,min(salary) from employees group by job_id)
  order by salary asc;
-- Interpretation: here finlly we got 21 rows about the employees with the min(salary) in the employee table,grouped by the job_id column with asc order

/* Task6:display the firstname,lastname,departmnt ids of the employees whose salary is greater than 60% of the sum of the salaries  ofall employees of their respective departments*/
(select sum(employees.salary) from employees where employees.department_id = employees.department_id); 
select first_name,last_name,department_id from employees where salary > 60%
  (select sum(employees.salary) from employees where employees.department_id = employees.department_id);