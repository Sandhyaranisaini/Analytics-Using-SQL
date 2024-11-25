-- Data driven analysis part 2
-- task1.1
select count(*) as TotalEmployees
from employees;
-- Interpretation:Total employees are 23 in employees table

-- Task1.2
select employeeNumber,lastName,firstName,email,jobtitle from employees;
-- Interpretation:employees list returned here.in this ist we have like employeenumber,firstname,lastname,email,jobtitle

-- task1.3
select jobTitle, count(*) as numberofjobemployees
from employees
group by jobTitle;
-- Interpretation:here hiehest employees in sales Rep feild the number is 17,and all another jobs have only one employee 

 select * from employees;
-- task1.4:
select * from employees
where reportsTo is null;
-- Interpretation:in this employees table Murphy don't have a manager

-- Task1.5:
select c.salesRepEmployeeNumber, sum(od.quantityOrdered * od.priceEach) as totalSales
from customers c
inner join orders o on c.customerNumber = o.customerNumber
inner join orderdetails od on o.orderNumber = od.orderNumber
group by c.salesRepEmployeeNumber
order by totalSales desc;
-- Interpretation:here  15 rows returned and highest total sales in salesrep employeeNumber is 1370. and  the lowest is 1166

-- Task1.6:
select c.salesRepEmployeeNumber, sum(od.quantityOrdered * od.priceEach) as totalSales
from customers c
inner join orders o on c.customerNumber = o.customerNumber
inner join orderdetails od on o.orderNumber = od.orderNumber
group by c.salesRepEmployeeNumber
order by totalSales desc;
-- Interpretation: here the most profitable sales is 1370(sales repemployeenumber) based on total sales

-- Task1.7:
select distinct e.firstName,e.lastName from employees e
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
where ( 
select sum(od2.quantityordered * od2.priceEach)
from customers c2
join orders o2 on c2.customerNumber=o2.customerNumber
join orderdetails od2 on o2.orderNumber= od2.orderNumber
where c2.salesRepEmployeeNumber=e.employeeNumber 
)> (
select avg(employee_total_sales)
from (
select c3.salesRepEmployeeNumber, sum(od3.quantityOrdered*od3.priceEach) as employee_total_sales
from customers c3
join orders o3 on c3.customerNumber=o3.customerNumber
join orderdetails od3 on o3.orderNumber=od3.orderNumber
join employees e2 on c3.salesRepEmployeeNumber=e2.employeeNumber
where e2.officeCode=e.officecode
group by c3.salesRepEmployeeNumber) as office_sales
)
order by e.lastName,e.firstName;
-- interpretation:here 7 rows returned with first and last names
-- Task2.1:
select c.customerNumber, avg(od.priceEach * od.quantityOrdered) AS avg_Order_Amount
from customers c
inner join orders o on c.customerNumber = o.customerNumber
inner join orderdetails od on o.orderNumber = od.orderNumber
group by c.customerNumber
order by c.customerNumber desc;
-- Interpretation:here 98 rows returend.and highest avg_order_amount is 2863.766458 under the customerNumber is 496.alter

-- task2.2:
select month(o.orderDate) as order_Month, count(*) as number_of_Orders
from orders o
group by month(o.orderDate)
order by order_Month ;
-- Interpretation: heighest number of orders in month of 11 and the number of orders is 63.and lowest is 17 under the 8 month

select * from orders;
-- Task2.3:
select * from orders where status = 'pending';
-- Interpretation: there is no pending status in shipment

-- Task 2.4:
select c.customerNumber, c.customerName, c.phone,o.orderNumber, o.orderDate, o.requiredDate,o.shippedDate
from orders o
inner join customers c on o.customerNumber = c.customerNumber;
-- Interpretation:here returned 326 rows with customernumber,customername,customer phone,ordernumber,orderDate,required date,shipped date

-- Task2.5:
select * from orders
order by orderDate desc;
-- Interpretation:10424,10425 have most recent date that is 2005-05-31

-- Task2.6:
select o.orderNumber, o.orderDate, SUM(od.quantityOrdered * od.priceEach) as total_sales
from orders o
inner join orderdetails od on o.orderNumber= od.orderNumber
group by o.ordernumber;
-- Interpretation:here 326 rows returned with ordernumber ,orderdate and total_sales

-- Task 2.7:
select o.orderNumber, o.orderDate, SUM(od.quantityOrdered * od.priceEach) as total_sales
from orders o
inner join orderdetails od on o.orderNumber= od.orderNumber
group by o.ordernumber
order by total_sales desc
limit 1;
-- Interpretation:10165 oredernumber have highest_value that is 67392.85

-- Task 2.8:
select o.orderNumber, o.orderDate, c.customerNumber, c.customerName, od.productCode, p.productName, od.quantityOrdered, od.priceEach
from orders o
inner join orderdetails od on o.orderNumber = od.orderNumber
inner join customers c on o.customerNumber = c.customerNumber
inner join products p on od.productCode = p.productCode;
-- Interpretation:here 1000 rows returned with orders with corresponding order details and also customerName,customerNumber,productcode

-- task 2.9:
select p.productCode, p.productName, sum(od.quantityOrdered * od.priceEach) as total_orders
from orderdetails od
inner join products p on od.productCode = p.productCode
group by p.productCode, p.productName
order by total_orders desc;
-- Interpretation:most frequently order product is S18_3232(productCode),	1992 Ferrari 360 Spider red(productName)

-- Task2.10:
select o.orderNumber, o.orderDate, sum(od.quantityOrdered * od.priceEach) as total_revenue
from orders o
inner join orderdetails od on o.orderNumber = od.orderNumber
group by o.orderNumber, o.orderDate;
-- Interpretation:here 326 rows returned orderNumber wise  with total revenue

-- Task2.11:
select o.orderNumber, o.orderDate, sum(od.quantityOrdered * od.priceEach) as total_revenue
from orders o
inner join orderdetails od on o.orderNumber = od.orderNumber
group by o.orderNumber, o.orderDate
order by total_revenue desc;
-- Interpretation:the most profitable orderNumber is 10165 and the highest total_revenue is 67392.85

-- Task2.12:
select o.orderNumber, o.orderDate, c.customerNumber, c.customerName,
       od.productCode, p.productName, p.productDescription, od.quantityOrdered, od.priceEach
from orders o
inner join orderdetails od on o.orderNumber = od.orderNumber
inner join customers c on o.customerNumber = c.customerNumber
inner join products p on od.productCode = p.productCode;
-- Interpretation:here 1000 rows returned all orders with product information and customer numbers,customerNames also

-- Task2.13:
select o.orderNumber, o.orderDate,o.shippedDate,o.requiredDate from orders o  
where shippedDate > requiredDate;
-- Interpretation:here we got only one ordernumber that is 10615

-- Task2.14:
select od1.productCode as product1, od2.productCode as product2, count(*) as combination_count 
from orderdetails od1
join orderdetails od2 on od1.orderNumber=od2.orderNumber
where od1.productCode < od2.productCode
group by od1.productCode,od2.productCode
order by combination_count desc limit 10;
-- interpretation:10 rows returned with product 1 and product 2 and combination count
-- Task 2.15:
select o.orderNumber, o.orderDate, sum(od.quantityOrdered * od.priceEach) as total_revenue
from orders o
inner join orderdetails od on o.orderNumber = od.orderNumber
group by o.orderNumber, o.orderDate
order by total_revenue desc
limit 10;
-- Interpretation:10165,10287,10310,10212,10207,10217,10204,10216,10222,10142 these are the top 10 most profitable ordernumber based on total revenue

-- Task 2.16:
delimiter $$
create trigger update_credit_limit_after_order
after insert on orders 
for each row
begin
 declare order_total_sales decimal(10,2);
select sum(quantityordered * priceEach) into order_total_sales
from orderdetails  
where orderNumber = new.orderNumber;
 update customers
set creditLimit = greatest(creditLimit - order_total_sales, 0)
where customerNumber = new.customerNumber;
end; $$  
-- interpretation:trigger created automatically updates a customer's credit limit after a new order is placed
-- Task 2.17:
delimiter $$
CREATE TRIGGER Product_quantity_changes_insert
AFTER INSERT ON orderdetails
FOR EACH ROW
BEGIN
  insert into product_quantity_log
(product_code,order_number,quantity_change,operation)
values(new.productCode, new.orderNumber, new.quantityOrdered, 'insert');
end; $$

create trigger product_quantity_update
after update on orderdetails
for each row
begin 
declare quantity_diff int;
set quantity_diff = new.quantityOrdered - old.quantityOrdered;
if quantity_diff !=0 then 
insert into product_quantity_log
(product_code,order_number,quantity_change,operation)values(new.productCode,new.orderNumber,quantity_diff,'update');
end if;
end; $$
-- interpretation:  trigger created automatically updates product_quantity after new quantity is placed.





