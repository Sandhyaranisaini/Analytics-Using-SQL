-- creating and manipulating database part 1
-- Task 1 : create a database to store employees' records
create database techmac_db;
use techmac_db;

-- Task 2 : create tables
-- 1. 'techyve_employees' table
create table techyve_employees (
EmployeeID varchar(20) primary key,
FirstName varchar(50),
LastName varchar(50),
Gender varchar(10),
Age int
);
-- 2.'techcloud_employees' table
create table techcloud_employees (
EmployeeID varchar(20) primary key,
FirstName varchar(50),
LastName varchar(50),
Gender varchar(10),
Age int
);
-- 3.'techsoft_employees' table
create table techsoft_employees (
EmployeeID varchar(20) primary key,
FirstName varchar(50),
LastName varchar(50),
Gender varchar(10),
Age int
);

-- Task3 : insert employee data
insert into techyve_employees (EmployeeID, FirstName, LastName, Gender, Age) values
('TH0001', 'Eli', 'Evans', 'male', 26),
('TH0002', 'Carlos', 'Simmons', 'male', 32),
('TH0003', 'Kathie', 'Bryant', 'Female', 25),
('TH0004', 'Joey', 'Hughes', 'Male', 41),
('TH0005', 'Alice', 'Matthews', 'Female', 52);

insert into techcloud_employees (EmployeeID, FirstName, LastName, Gender, Age) values
('TC0001', 'Teresa', 'Bryant', 'Female', 39),
('TC0002', 'Alexis', 'Petterson', 'Male', 48),
('TC0003', 'Rose', 'Bell', 'female', 42),
('TC0004', 'Gemma', 'Watkins', 'Female', 44),
('TC0005', 'Kingston', 'Martinez', 'Male', 29);

insert into techsoft_employees (EmployeeID, FirstName, LastName, Gender, Age) values
('TS0001', 'Peter', 'Burtler', 'Male', 44),
('TS0002', 'Harold', 'Simmons', 'Male', 54),
('TS0003', 'Juliana', 'Sanders', 'Female', 36),
('TS0004', 'Paul', 'Ward', 'Male', 29),
('TS0005', 'Nicole', 'Bryant', 'Female', 30);

-- Task 4: backup tables and names

create table techyve_employees_backup like techyve_employees;

create table techcloud_employees_backup like techcloud_employees;

create table techsoft_employees_backup like techsoft_employees;

Insert into techyve_employees_backup
select * from techyve_employees;

insert into techcloud_employees_backup
select * from techcloud_employees;

insert into techsoft_employees_backup
select * from techsoft_employees;

-- Task 5: delete the data
delete from techyve_employees
where EmployeeID in ('TH0003', 'TH0005');

delete from techcloud_employees
where EmployeeID in ('TC0001', 'TC0004'); 
-- creating and manipulating part 2
-- practice 2 task 1.1

alter table techyve_employees modify column firstname varchar(100);
alter table techyve_employees modify column lastname varchar(50);
alter table techcloud_employees modify column firstname varchar(100);
alter table techcloud_employees modify column lastname varchar(50);
alter table techsoft_employees modify column firstname varchar(100);
alter table techsoft_employees modify column lastname varchar(50);

-- task 1.2
alter table techyve_employees alter column age set  default '21';
alter table techcloud_employees alter column age set default '21';
alter table techsoft_employees alter column age set default '21';

-- task 1.3
alter table techyve_employees
add constraint check_age
check(age between 21 and 55);

alter table techcloud_employees
add constraint check_ageofcloud
check(age between 21 and 55);

alter table techsoft_employees
add constraint check_ageofsoft
check(age between 21 and 55);

-- task 1.4
alter table techyve_employees add column username char(50) not null;
alter table techyve_employees add column password char(50) not null;
alter table techcloud_employees add column username char(50) not null;
alter table techcloud_employees add column password char(50) not null;
alter table techsoft_employees add column username char(50) not null;
alter table techsoft_employees add column password char(50) not null;

-- task 1.5
alter table techyve_employees add constraint check_gender check (gender in ('male', 'female'));
alter table techcloud_employees add constraint check_genderofcloud check (gender in ('male', 'female'));
alter table techsoft_employees add constraint check_genderofsoft check (gender in ('male', 'female'));

-- Task 2
alter table techyve_employees add communication_proficiency varchar(100);
alter table techyve_employees add constraint check_proficiency check(communication_proficiency between 1 and 5);
alter table techyve_employees alter column communication_proficiency set default 1;
desc techyve_employees;

alter table techcloud_employees add communication_proficiencyofcloud varchar(100);
alter table techcloud_employees add constraint check_proficiencyofcloud check(communication_proficiencyofcloud between 1 and 5);
alter table techcloud_employees alter column communication_proficiencyofcloud set default 1;
desc techyve_employees;

alter table techsoft_employees add communication_proficiencyofsoft varchar(100);
alter table techsoft_employees add constraint check_proficiencyofsoft check(communication_proficiencyofsoft between 1 and 5);
alter table techsoft_employees alter column communication_proficiencyofsoft set default 1;
desc techsoft_employees;

-- task 3
-- create backups of original tables
create table techyve_employees_backup as select * from techyve_employees;
create table techcloud_employees_backup as select * from techcloud_employees;

-- create new table techyvecloud_employees
create table techyvecloud_employees (
EmployeeID varchar(10),
FirstName varchar(50),
LastName varchar(50),
Gender varchar(10),
Age int,
proficiencylevel int
);
-- insert data from techcloud_employees
insert into techyvecloud_employees  (EmployeeID, FirstName, LastName,	Gender, Age, proficiencylevel )
select EmployeeID, FirstName, LastName, Gender, Age,communication_proficiency from techyve_employees;
insert into techyvecloud_employees (EmployeeID, FirstName, LastName,	Gender, Age, proficiencylevel )
select EmployeeID, FirstName, LastName, Gender, Age,communication_proficiency from techcloud_employees;
create table techyve_employees_backup as select * from techyve_employees;
create table techcloud_employees_backup as select * from techcloud_employees;





