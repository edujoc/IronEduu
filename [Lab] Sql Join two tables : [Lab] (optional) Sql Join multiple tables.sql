# Lab | SQL Queries - Join Two Tables

# 1. Which actor has appeared in the most films?

select
count(film_actor.actor_id),
actor.first_name,
actor.last_name
from actor
inner join film_actor
on actor.actor_id = film_actor.actor_id
group by film_actor.actor_id
order by count(film_actor.actor_id) desc
limit 1;


# 2. Most active customer (the customer that has rented the most number of films)

select
customer.customer_id,
count(*) as most_rented_number_of_films
from rental 
inner join customer
on rental.customer_id = customer.customer_id
group by customer.customer_id
order by count(most_rented_number_of_films) desc
limit 1;

# 3. List number of films per category.

select
category,
count(*) as films
from film_list
group by category
having count(*)
order by films desc;

# 4. Display the first and last names, as well as the address, of each staff member.

SELECT 
first_name, 
last_name, 
address
FROM staff
INNER JOIN address
ON staff.address_id = address.address_id;

# 5. Display the total amount rung up by each staff member in August of 2005.

SELECT 
first_name, 
last_name, 
sum(amount)
from staff
inner join payment
on staff.staff_id = payment.staff_id
where month(payment.payment_date) = 8
and year (payment.payment_date) = 2005
group by payment.staff_id
order by last_name;

# 6. List each film and the number of actors who are listed for that film.

select
title, 
count(*) number_of_actors
from film
inner join film_actor 
on film.film_id = film_actor.film_id
group by title
order by number_of_actors desc;

# 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name. Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try.

select
last_name,
first_name,
sum(amount) 'total_amount_paid'
from payment
inner join customer
on payment.customer_id = customer.customer_id
group by payment.customer_id
order by last_name;

# Lab | SQL Joins on multiple tables

# 1. Write a query to display for each store its store ID, city, and country.

select
store_id,
city,
country
from store
join address
on(store.address_id=address.address_id)
join city 
on(address.city_id=city.city_id)
join country
on(city.country_id=country.country_id);

# 2. Write a query to display how much business, in dollars, each store brought in.

select
staff.store_id,
sum(payment.amount)
from payment
join staff on(payment.staff_id=staff.staff_id)
group by store_id;







