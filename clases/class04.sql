#1
select title, special_features, rating from film
where rating = 'PG-13';
#2
select length from film group by length ;
#3
select title,rental_rate,replacement_cost from film
where replacement_cost between 20.00 and 24.00;
#4
select title,rating, special_features,c.name from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
where special_features like '%Behind the Scenes%';
#5
select a.first_name,a.last_name,f.title from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film f on f.film_id = fa.film_id
where f.title = 'ZOOLANDER FICTION';
#6
select ad.address, c.city, co.country from store s
inner join address ad on s.address_id = ad.address_id
inner join city c on ad.city_id = c.city_id
inner join country co on c.country_id = co.country_id
where s.store_id = 1;


