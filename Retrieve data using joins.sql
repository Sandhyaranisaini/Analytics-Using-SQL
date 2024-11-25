use HR;
-- Task 1;
select *from employees;
select * from departments;
select employees.employee_id,departments.department_id,employees.first_name,employees.last_name
from employees inner join
departments on departments.department_id = employees.department_id where departments.department_name = 'IT';
-- Interpretation: Alexander Hunold,Bruce Ernst,David Austin,Valli Pataballa,Diana Lorentz these 5 mmbers are the IT employees

-- Task2;
use hr;
select department_name from departments;
select department_name, max(salary) as 'Max Salary', min(salary) as 'Min salary'from employees 
join departments on employees.department_id =departments.department_id
group by department_name;

-- task 3
select* from locations;
select* from departments;
select*from employees;
select locations.city,  count(employees.employee_id)as 'count of employees' from employees join departments join locations 
 on employees.department_id = departments.department_id and departments.location_id = locations.location_id
 group by (locations.city) order by (count(employees.employee_id) ) desc limit 10;
-- interpretation : here south san francisco has top employees that is 45

-- Task 4
select * from employees;
select * from job_history;
select employees.employee_id,employees.first_name,employees.last_name,job_history.end_date from employees
join job_history on employees.employee_id = job_history. employee_id
where job_history.end_date = '1999-12-31';
-- Interpretation: 3 employees are there last workingdate on 1999-12-31

-- Task 5
select * from employees;
select *from departments;
select employees.employee_id,employees.first_name,departments.department_name, year(current_date())-year(employees.hire_date)as 'total experience'
from employees join departments 
on employees.department_id = departments.department_id



