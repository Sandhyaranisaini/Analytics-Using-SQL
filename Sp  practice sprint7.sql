-- Create database
CREATE DATABASE IF NOT EXISTS librarydb;
-- activate database
USE librarydb;
-- Create Books table
CREATE TABLE books (
 book_id INT PRIMARY KEY AUTO_INCREMENT,
 title VARCHAR(255) NOT NULL,
 author VARCHAR(255) NOT NULL,
 publication_year INT,
 category VARCHAR(50) NOT NULL
);
-- Create Borrowers table
CREATE TABLE borrowers (
 borrower_id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(255) NOT NULL,
 age_group VARCHAR(20) NOT NULL,
 email VARCHAR(100) UNIQUE NOT NULL
);
-- Create Loans table
CREATE TABLE loans (
 loan_id INT PRIMARY KEY AUTO_INCREMENT,
 book_id INT NOT NULL,
 borrower_id INT NOT NULL,
 loan_date DATE NOT NULL,
 return_date DATE DEFAULT NULL,
 FOREIGN KEY (book_id) REFERENCES books(book_id),
 FOREIGN KEY (borrower_id) REFERENCES borrowers(borrower_id)
);
-- Insert records into Books table
INSERT INTO books (title, author, publication_year, category)
VALUES ('Pride and Prejudice', 'Jane Austen', 1813, 'Fiction'),
 ('The Lord of the Rings', 'J. R. R. Tolkien', 1954, 'Fantasy'),
 ('To Kill a Mockingbird', 'Harper Lee', 1960, 'Literature'),
 ('The Hitchhiker\'s Guide to the Galaxy', 'Douglas Adams', 1979, 'Science Fiction'),
 ('The Catcher in the Rye', 'J. D. Salinger', 1951, 'Coming-of-Age'),
 ('Frankenstein', 'Mary Shelley', 1818, 'Gothic Fiction'),
 ('Animal Farm', 'George Orwell', 1945, 'Dystopian'),
 ('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'American Literature'),
 ('1984', 'George Orwell', 1949, 'Dystopian'),
 ('The Adventures of Sherlock Holmes', 'Arthur Conan Doyle', 1892, 'Mystery');
-- Insert records into Borrowers table
INSERT INTO borrowers (name, age_group, email)
VALUES ('Alice Smith', 'Adults (25-64)', 'alice.smith@example.com'),
 ('Bob Johnson', 'Teens (13-19)', 'bob.johnson@example.com'),
 ('Charlie Brown', 'Children (0-12)', 'charlie.brown@example.com'),
 ('Diana Davis', 'Adults (25-64)', 'diana.davis@example.com'),
 ('Emily Evans', 'Teens (13-19)', 'emily.evans@example.com'),
 ('Frank Garcia', 'Adults (25-64)', 'frank.garcia@example.com'),
 ('Grace Hernandez', 'Children (0-12)', 'grace.hernandez@example.com'),
 ('Isaac Jackson', 'Teens (13-19)', 'isaac.jackson@example.com'),
 ('Jessica Jones', 'Adults (25-64)', 'jessica.jones@example.com'),
 ('Kevin Kim', 'Children (0-12)', 'kevin.kim@example.com');
-- Insert records into Loans table
INSERT INTO loans (book_id, borrower_id, loan_date, return_date)
VALUES (1, 1, '2024-02-11', NULL),
 (2, 1, '2024-02-12',NULL),
 (3, 4,'2024-02-15', '2024-02-28'),
 (4, 2, '2024-02-17',NULL),
 (5, 4, '2024-02-20',NULL),
 (6, 5, '2024-02-24',NULL),
 (7,8, '2024-02-26',NULL),
 (8, 7, '2024-03-01',NULL),
 (9, 2, '2024-03-05', '2024-03-18'),
 (10, 9, '2024-03-13',NULL);
SELECT * FROM books;
SELECT * FROM borrowers;
SELECT * FROM loans;
-- Task 1: find most popular books by age group
 
 delimiter $$ 
 create procedure Get_popularbooks_by_Age_group(in agegroup varchar(50))
 begin
 select b.title, b.author, count(*) as borrows
 from books b
 inner join loans l on b.book_id = l.book_id
 inner join borrowers br on br.borrower_id = l.borrower_id
 where br.age_group = agegroup
 group by b.title,b.author
 order by borrows desc 
 limit 10;
 
 end; $$
 
 call  Get_popularbooks_by_Age_group ('Adults (25-64)');
 -- Interpretation: Pride and Prejudice,The Lord of the Rings,To Kill a Mockingbird,The Catcher in the Rye,The Adventures of Sherlock Holmes these are most popular books agegroup of "25-64"(adults)
 
 -- task2: count loans month wise
 
 delimiter $$
 create procedure  get_loans_per_month_by_year(in year int)
 begin
 select month(loan_date) as loan_month, count(*) as loan_count
 from loans
 where year(loan_date) = year
 group by month(loan_date)
 order by loan_month;
 end $$
 
 call get_loans_per_month_by_year(2024)
 -- interpretation: there are 2 monthly only in 2024 year,those february,march.in feb month number of loans = 7,in march month number of loans = 3


-- Task 4: 
delimiter $$
create procedure update_loanreturn(in loanID int)
begin
update loans 
set return_date = curdate()
where loan_id = loanID;

end; $$

call update_loanreturn(5);

-- Task5:
delimiter $$
create procedure update_Borrowers(in borrowerID int, in new_name varchar(100)  , in new_email varchar(100) )
begin
declare new_email varchar(100);

update borrowers set email = ifnull(new_email,email)
where borrower_id = in_borrower_id;

end;$$

-- Task3:
delimiter $$
create procedure create_newloanentry(in bookID int, in borrowerID int)
begin
declare loanperiod int;
declare duedate DATE;
set duedate = curdate() + Interval loanperiod day;
insert into loans (book_id,borrower_id,loan_date,return_date)
values(bookID,borrowerID,curdate(),duedate);
end; $$
 call  create_newloanentry(3,2);
 
 -- Task6:
 delimiter $$
 create procedure check_borrower_eligibility(in borrowerID int, out O_overduecount int,out_eligible varchar(50))
  begin 
  select count(*) into O_overduecount 
  from loans
  where borrower_id =  borrowerID
  and return_date is null;
  
-- conditional statement
if  O_overduecount > 0 then
set Out_eligible = "not eligible";
else
set Out_eligible = "eligible";
end if;
end; $$

