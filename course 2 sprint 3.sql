use sakila;
select * from film;
-- Task 1
select * from customer;
select customer_id, store_id, first_name,last_name,email,address_id, active,create_date, last_update from customer where active = 0;
-- Interpretation: there are 15 members are inactie.

-- task2
select first_name,last_name,email from customer where active = 0;
-- Interpretation:SANDRA,JUDITH,SHEILA,ERICA,HEIDI,PENNY,KENNETH,,HARRY,NATHAN,THEODORE,MAURICE,BEN,CHRISTIAN,JIMMIE,TERRANCE these are the inactive customers
-- task3
select max(store_id) from customer where active = 0;
-- Interpretation:2 is the maximum store_id for inctive customer;
-- Task 4
select * from film;
select title from film where rating = 'PG-13';
-- Interpretation:there are 223 movies in the rating of 'PG-13'

-- Task5
select title from film where rating = 'PG-13' order by last_update desc limit 3;
-- Interpretation: AIRPLANE SIERRA,ALABAMA DEVIL,ALTER VICTORY these are the top 3 based on longest running time;

-- Task 6
select * from film;
select title as title, sum(rental_duration) as total_rental_duration
from film
join rental r on film_id = film_id
where rating = 'PG-13'
group by title
order by total_rental_duration desc 
limit 3;
-- Interpretation :VALENTINE VANISHING,WANDA CHAMBER,VIETNAM SMOOCHY these are the most popular PG-13 movies based on rental duration

-- task 7
select avg(rental_rate) as average_rental_rate from film;
-- Interpretation 2.980000 is the average   rental_cost of the movies

-- Task 8
select sum(replacement_cost) as total_replacement_cost from film;
-- Interpretation:total_replacement-cost is 19984

-- Task9
select * from category;
select category_id,name from category where name in ('Animation', 'Children');
select c.name as category_name,count(fc.film_id) as number_of_film
from film_category fc
join category c on fc.category_id = c.category_id
where fc.category_id in (2,3) -- replace with actual category_ids for Animation and childran
group by c.name;
-- Interpretation: In Animation field number of films 66, in children field number of films is 60
