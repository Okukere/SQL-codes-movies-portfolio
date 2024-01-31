--Show the actor's first_name and last_name with Nick, Ed and Jennifer as their first names

select first_name,last_name
from actor
where first_name in ('Nick', 'Ed', 'Jennifer')

--Show only last_name of an actor whose first names are Ed, Nick and Jennifer

select last_name
from actor
where first_name in ('Nick', 'Ed', 'Jennifer')

--From the film table, show the title, and film id. from the Inventory table, show inventory_id. Do 
--this when the film_id on the film table match film_id on the inventory table.

select f.title, f.film_id, i.inventory_id
from inventory i
join film f
on i.film_id = f.film_id

--Show me first_name, and last_name of the actors whose first_name (Ed, Nick and Jennifer) are 
--distinct

select distinct first_name,last_name
from actor
where first_name in ('Nick', 'Ed', 'Jennifer')

--Show the top 5 rows from the inventory table and rental table

select *
from inventory i
join rental r
on r.inventory_id = i.inventory_id
limit 5

--Write a query to return 10 rows of rental_id, rental_date, and payment_id, ordered by the 
--amount in descending order from the rental and payment table

select r.rental_id, r.rental_date, p.payment_id, p.amount
from rental r
join payment p
on r.rental_id = p.rental_id
order by amount desc
limit 10

--Show all the other details in the actor table where actor_id is empty

select *
from actor
where actor_id is null

--Show all the other details in the actor table where actor_id is not empty

select *
from actor 
where actor_id is not null

--Unlike count, the sum can only be used for numeric columns. Let’s see the sum of the amount 
--from the payment table, let the output title be sum_amt

select sum(amount) as sum_amt
from payment 

--Extract both the Maximum and minimum amount in the payment table

select max(amount)as max_amt, min(amount) as min_amt
from payment

--Show the sum of payment made by each payment_id

select payment_id, sum(amount) as total_amt
from payment
group by payment_id
order by total_amt desc

--Show the sum of the amount by each payment id that is greater than 5.99

select payment_id, sum(amount) as total_amt
from payment
where amount > 5.99
group by payment_id

--Show the sum of rental_rate of films by month

with table1 as (
				select f.film_id, f.rental_rate, i.inventory_id
				from film f
				join inventory i
				on f.film_id = i.film_id
			   ),
				table2 as (
				select rental_id, extract(month from rental_date) as rental_month, inventory_id
			    from rental
				)
select rental_month, sum(rental_rate) as total_rental_rate
from table1 t1
join table2 t2
on t1.inventory_id = t2.inventory_id
group by rental_month;
		   

with table1 as (
				select f.film_id, f.rental_rate, i.inventory_id
				from film f
				join inventory i
				on f.film_id = i.film_id
			   ),
				table2 as (
				select rental_id, to_char(rental_date, 'month' ) as rental_month, inventory_id
			    from rental
				)
select rental_month, sum(rental_rate) as total_rental_rate
from table1 t1
join table2 t2
on t1.inventory_id = t2.inventory_id
group by rental_month;

--Show film.id, film.title, film. description and film_length. categorize film.length
--into 4 categories(over 100, 86-100, 72-86 and under 72)

select film_id, title, description,
	case when length > 100 then 'series'
		when length > 85 then 'full_film'
		when length > 71 then 'short_movie'
		else 'under 72' end as film_category
from film;

--Show the COUNT of the four categories above
 select film_category, count(film_category)
 from 
	(select 
		case when length > 100 then 'series'
			when length > 85 then 'full_film'
			when length > 71 then 'short_movie'
			else 'under 72' end as film_category
	from film) x
group by film_category;

--Separate the first three, and last 8 numbers of the phones in the address table into another column

SELEct left(phone,3) as country_code, right(phone,8) as phone_no
from address

--Split the email in the customer table to show the name in caps before the full stop (Repeat the task for Proper case)

select email, upper(split_part(email,'.',1)) as first_name, upper(split_part(split_part(email,'@',1), '.',2)) as last_name
from customer

--View all the columns in the city and add two columns to show the city as upper and lowercase

select *, upper(city) as cap_city, lower(city) as lower_city
from city

--Combine first_name and last_name from the customer table to become full_name

select first_name, last_name, concat(first_name, last_name) as full_name
from customer

