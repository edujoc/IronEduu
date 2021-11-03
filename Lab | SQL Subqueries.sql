# Lab | SQL Subqueries

# 1. How many copies of the film Hunchback Impossible exist in the inventory system?

select
title,
count(inventory_id)
from film f
inner join inventory i
on f.film_id=i.film_id
where title="Hunchback Impossible";

# 2. List all films whose length is longer than the average of all the films.

select title, length from film
where length > (select avg(length) from film)
order by length;

# 3. Use subqueries to display all actors who appear in the film Alone Trip.

select
first_name,
last_name
from actor
where actor_id in (
select actor_id
from film_actor
where film_id in (
select film_id
from film
where lower(title)=lower('Alone Trip')
));

# 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

select
film_id,
title
from film
where film_id in (
select film_id
from film_category
where category_id in (
select category_id
from category
where name = 'Family'
));


# 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

# subquery
select
first_name,
last_name,
email
from customer
where address_id in (
select address_id
from address
where city_id in (
select city_id
from city
where country_id in (
select country_id
from country
where country = 'Canada'
)));

# join
select
first_name,
last_name,
email
from customer
join address
on customer.address_id=address.address_id
join city
on address.city_id=city.city_id
join country
on city.country_id=country.country_id
where country='Canada';

# 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select
count(film_actor.actor_id),
actor.first_name,
actor.last_name
from actor
inner join film_actor
on actor.actor_id=film_actor.actor_id
group by film_actor.actor_id;

select *
from actor_info
where actor_id=107;

SELECT concat(first_name, " ", last_name) as actor_name,
    title
FROM
    actor
        INNER JOIN
    film_actor USING (actor_id)
        INNER JOIN
    film USING (film_id)
WHERE
    actor_id = (SELECT
            actor_id
        FROM
            actor
                INNER JOIN
            film_actor USING (actor_id)
                INNER JOIN
            film USING (film_id)
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1);




# 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments



select
first_name,
last_name,
sum(payment.amount)
from payment
join customer
on payment.customer_id=customer.customer_id
group by customer.first_name,
customer.last_name
order by sum(payment.amount) desc
limit 1;

select customer_id from customer
where first_name=("Karl") and last_name=("Seal");


SELECT concat(first_name, " ", last_name) as customer_name,
    title
FROM
    customer
        INNER JOIN
    payment USING (customer_id)
        INNER JOIN
    rental USING (rental_id)
		INNER JOIN
        inventory using (inventory_id)
        INNER JOIN
        film using (film_id)
WHERE
    customer.customer_id = 526
    order by title;




# 8. Customers who spent more than the average payments.



#get the average

select avg(amount) from payment;


select distinct
first_name,
last_name
as customer_name, amount
from customer
inner join payment using(customer_id)
where amount > (select avg(amount) from payment)
order by amount;




select
customer.customer_id,
customer.first_name,
customer.last_name,
avg(payment.amount)
from customer
inner join payment
on payment.customer_id=customer.customer_id
group by customer.customer_id
order by avg(payment.amount) desc;






