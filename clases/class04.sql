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
#7
select f1.title as film1_title, f1.rating, f2.title as film2_title, f2.rating from film f1
inner join film f2 on f1.rating = f2.rating
where f1.film_id <> f2.film_id;
#8
select distinct f.title, f.release_year, st.first_name as manager_of_store2 from film f
inner join inventory inv on f.film_id = inv.film_id
inner join store s on s.store_id = inv.store_id
inner join staff st on s.manager_staff_id = st.staff_id
where s.store_id = 2;	


