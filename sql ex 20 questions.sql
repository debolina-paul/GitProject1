#1- Afficher les 10 locations les plus longues (nom/prenom client, film, video club, durée)

SELECT first_name, last_name, f.title, datediff(return_date,rental_date) as d, s.store_id
FROM customer as c
JOIN rental as r ON c.customer_id = r.customer_id
join inventory as i on r.inventory_id = i.inventory_id
join store as s on i.store_id = s.store_id
join film as f on i.film_id = f.film_id
ORDER BY d DESC
LIMIT 10;

#2- Afficher les 10 meilleurs clients actifs par montant dépensé (nom/prénom client, montant dépensé)

SELECT first_name, last_name, SUM(amount) as s
FROM payment as p
join rental as r on p.rental_id = r.rental_id
join customer as c on c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY s DESC 
LIMIT 10;

#3- Afficher la durée moyenne de location par film triée de manière descendante
SELECT f.title, avg(datediff(return_date,rental_date)) as avg_film 
FROM film as f
JOIN inventory as i on f.film_id = i.film_id
JOIN rental as r on i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY avg_film DESC;


#4- Afficher tous les films n'ayant jamais été empruntés
SELECT title
from film as f
join inventory as i on f.film_id = i.film_id
Left join rental as r on r.inventory_id = i.inventory_id
where r.rental_id is null;

#5- Afficher le nombre d'employés (staff) par video club

SELECT COUNT(staff_id)
FROM staff
GROUP BY store_id;


#6- Afficher les 10 villes avec le plus de video clubs

SELECT city,count(store_id) as co
FROM city as c
JOIN address as a on c.city_id = a.city_id
JOIN store as s on a.address_id = s.address_id
GROUP BY city
order by co DESC
LIMIT 10;


#7- Afficher le film le plus long dans lequel joue Johnny Lollobrigida

select film.title, actor.first_name, actor.last_name, film.length
from film_actor 
join film on film_actor.film_id = film.film_id
join actor on film_actor.actor_id = actor.actor_id
where actor.last_name='LOLLOBRIGIDA' and actor.first_name='JOHNNY'
order by film.length desc
limit 1;

#8-Afficher le temps moyen de location du film 'Academy dinosaur'
select film.title, avg(datediff(rental.return_date,rental.rental_date)) as duree_moyenne 
from film
join inventory on inventory.film_id=film.film_id
join rental on rental.inventory_id = inventory.inventory_id 
where film.title="ACADEMY DINOSAUR"
group by film.title;

select film.title, count(rental.rental_id) 
from film
join inventory on inventory.film_id=film.film_id
join rental on rental.inventory_id = inventory.inventory_id 
where film.title="ACADEMY DINOSAUR"
group by film.title;

#9-Afficher les films avec plus de deux exemplaires en inventaire (store id, titre du film, nombre d'exemplaires)
select inventory.store_id ,film.title, count(inventory.inventory_id) as nb_explr
from inventory
join film on inventory.film_id=film.film_id
group by inventory.store_id, film.title
having nb_explr >2;

#10-Lister les films contenant 'din' dans le titre
select film.title
from film
where film.title like "%din%";

#11-Lister les 5 films les plus empruntés
select  film.title, count(rental.rental_id) as nb_emprunts
from rental
join inventory on rental.inventory_id=inventory.inventory_id
join film on inventory.film_id=film.film_id
group by film.title
order by nb_emprunts desc
limit 5;

#12-Lister les films sortis en 2003, 2005 et 2006
select film.title, film.release_year
from film
where film.release_year in (2003, 2005,2006);

#13- Afficher les films ayant été empruntés mais n'ayant pas encore été restitués, triés par date d'emprunt. 
#Afficher seulement les 10 premiers.
select film.title, rental.rental_date, rental.return_date
from rental
join inventory on rental.inventory_id=inventory.inventory_id
join film on inventory.film_id=film.film_id
where rental.return_date is null
order by rental.rental_date 
limit 10;

#14- Afficher les films d'action durant plus de 2h

select category.name, film.title, film.length
from film
join film_category on film_category.film_id=film.film_id
join category on category.category_id=film_category.category_id
where category.name='ACTION' and film.length>120;

#15- Afficher tous les utilisateurs ayant emprunté des films avec la mention NC-17

select distinct customer.customer_id, customer.first_name, customer.last_name, film.rating
from customer
join rental on rental.customer_id=customer.customer_id
join inventory on inventory.inventory_id=rental.inventory_id
join film on film.film_id=inventory.film_id
where film.rating='NC-17';

#16-Afficher les films d'animation dont la langue originale est l'anglais

select title, eng_film.name
from film_category,
(select film_id, film.title, language.name
from film join language 
on film.original_language_id=language.language_id and language.name='English') as eng_film,
category
where film_category.film_id = eng_film.film_id and 
film_category.category_id = category.category_id and
category.name = 'ANIMATION';


#17-Afficher les films dans lesquels une actrice nommée Jennifer a joué (bonus: en même temps qu'un acteur nommé Johnny)

select film.title, count(film_actor.film_id) 
from actor 
join film_actor on actor.actor_id=film_actor.actor_id
join film on film.film_id=film_actor.film_id
where actor.first_name in ('Jennifer','Johnny')
group by film.title
having count(film_actor.film_id)>=2;

#18-Quelles sont les 3 catégories les plus empruntées?

select  category.name, count(rental.rental_id) as nb_emprunts
from rental
join inventory on rental.inventory_id=inventory.inventory_id
join film on inventory.film_id=film.film_id
join film_category on film_category.film_id=film.film_id
join category on category.category_id=film_category.category_id
group by category.name
order by nb_emprunts desc
limit 3;

#19-Quelles sont les 10 villes où on a fait le plus de locations?

select city.city, count(rental.staff_id) as nb_locations
from rental
join staff on rental.staff_id=staff.staff_id
join store on store.store_id=staff.store_id
join address on store.address_id=address.address_id
join city on city.city_id=address.city_id
group by city.city
order by nb_locations desc
limit 10;

#20-Lister les acteurs ayant joué dans au moins 1 film

select actor.first_name, actor.last_name, count(film_actor.film_id) 
from actor 
join film_actor on actor.actor_id=film_actor.actor_id
group by actor.first_name, actor.last_name
having count(film_actor.film_id)>=1;