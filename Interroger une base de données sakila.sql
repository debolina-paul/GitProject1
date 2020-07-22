

#Interrogations avancées

-- 1
select *, 
	concat(
    day(rental_date),
    ' ', 
    CASE MONTH(rental_date)
         WHEN 1 THEN 'janvier'
         WHEN 2 THEN 'février'
         WHEN 3 THEN 'mars'
         WHEN 4 THEN 'avril'
         WHEN 5 THEN 'mai'
         WHEN 6 THEN 'juin'
         WHEN 7 THEN 'juillet'
         WHEN 8 THEN 'août'
         WHEN 9 THEN 'septembre'
         WHEN 10 THEN 'octobre'
         WHEN 11 THEN 'novembre'
         ELSE 'décembre'
	END, 
    ' ', 
    year(rental_date)) as cas_du_case,
    concat(day(rental_date),' ',MONTHNAME(rental_date),' ',year(rental_date)),
    DATE_FORMAT(rental_date, '%d %M %Y')
from rental
where year(rental_date) = 2006 ;

-- 2
select *, datediff(return_date, rental_date) as duree_location
from rental;

-- 3
select *,DATE_FORMAT(rental_date, '%d %M %Y')
from rental
where year(rental_date) = 2005
#and extract(HOUR from rental_date)<1;
#and hour(rental_date)<1;
and TIME(rental_date) < '01:00:00';

-- 4
select * 
from rental
where month(rental_date) in (4,5)
order by rental_date;

-- 5
select title 
from film
#where title not like 'Le%';
where LEFT(title,2) <> 'Le';

-- 6
select	*, 
		case rating
			when 'NC-17' then 'oui'
            else 'non'
		end as 'oui ou non',
        # on peut faire avec IF
        if(rating='NC-17','oui','non') as 'avec_is'
from film
where rating in ('PG-13','NC-17');

-- 7
select * 
from category
where LEFT(name,1) in ('A','C');

-- 8
select LEFT(name,3)
from category;

-- 9
select *, replace(first_name,'E','A') as modified_first_name
from actor
LIMIT 100;




#Les jointures


--1
# Lister les 10 premiers films ainsi que leur langues.
SELECT title, name as langue 
from film, language limit 10;

SELECT title, name as langue
from film join language
on film.language_id = language.language_id
LIMIT 10;

SELECT title, name FROM film JOIN language ON film.language_id = language.language_id LIMIT 10;

---2
#2 Afficher les film dans les quel à joué « JENNIFER DAVIS » sortie en 2006

SELECT * FROM actor ;

SELECT title FROM film ;
SELECT * FROM language ;


SELECT title, actor name FROM film JOIN ON title.film_id = name.actor_id WHERE first_name = JENNIFER AND last_name = DAVIS;



# 2. Afficher les film dans les quel à joué « JENNIFER DAVIS » sortie en 2006.

SELECT film.title , actor.first_name , actor.last_name , film.release_year
FROM actor 
JOIN film_actor 
ON actor.actor_id = film_actor.actor_id
JOIN film ON film.film_id = film_actor.film_id
WHERE (actor.last_name = 'DAVIS' 
AND actor.first_name = 'JENNIFER')
AND film.release_year = 2006 ;


# 2. Afficher les film dans les quel à joué « JENNIFER DAVIS » sortie en 2006.

SELECT film.title , actor.first_name , actor.last_name , film.release_year
FROM actor 
JOIN film_actor 
ON actor.actor_id = film_actor.actor_id
JOIN film 
ON film.film_id = film_actor.film_id AND film.release_year = 2006 
WHERE (actor.last_name = 'DAVIS' 
AND actor.first_name = 'JENNIFER') ;

#2
SELECT film.title , actor.first_name , actor.last_name , film.release_year
FROM actor 
JOIN film_actor 
	ON actor.actor_id = film_actor.actor_id 
	AND (actor.last_name = 'DAVIS' 
	AND actor.first_name = 'JENNIFER') 
JOIN film 
	ON film.film_id = film_actor.film_id 
	AND film.release_year = 2006 ;
    
#3 Afficher le noms des client ayant emprunté « ALABAMA DEVIL »
# film , inventory , rental , customer 
SELECT customer.last_name , film.title FROM customer
JOIN rental ON rental.customer_id = customer.customer_id
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN film ON film.film_id = inventory.film_id AND film.title = "ALABAMA DEVIL";
#WHERE film.title = "ALABAMA DEVIL";

select C.last_name, C.first_name,title
from customer as C
join rental as R on C.customer_id = R.customer_id
join inventory as I ON I.inventory_id = R.inventory_id
join film as F on I.film_id = F.film_id
WHERE title = "ALABAMA DEVIL";




#4 Afficher les films louer par des personne habitant à « Woodridge ». 
#   Checked if there are any movies that have never been borrowed
# film , inventory , rental , customer , address , city

#1st part
SELECT city.city , film.title, store.store_id FROM city
JOIN address ON address.city_id = city.city_id 
JOIN store ON store.store_id = store.address_id 
JOIN inventory ON inventory.inventory_id = inventory.store_id
JOIN film ON film.film_id = inventory.film_id
WHERE city.city = "Woodridge";

SELECT first_name , last_name ,city , title FROM city
JOIN address ON address.address_id = address.city_id
JOIN customer ON customer.customer_id = customer.adress_id
JOIN rental ON rental.rental_id = rental.customer_id
JOIN inventory ON inventory.inventory_id = inventory.rental_id
JOIN film ON film.film_id = inventory.film_id
WHERE city.city = "Woodridge"; 



UNION 

#2nd part

SELECT F.title
from film as F
JOIN inventory as I on F.film_id = I.film_id
left join rental as R on I.inventory_id = R.inventory_id
WHERE R.rental_id IS NULL;

 --5
 
 #Quel sont les 10 films dont la durée d’emprunt à été la plus courte
 
SELECT F.title,
TIMESTAMPDIFF(HOUR, UNIX_TIMESTAMP(RE.rental_date), UNIX_TIMESTAMP(RE.return_date)) as Duree
FROM rental AS RE
INNER JOIN inventory AS INV 
ON INV.inventory_ID=RE.inventory_id 
INNER JOIN film AS F 
ON F.film_id=INV.film_id 
HAVING Duree IS NOT NULL 
ORDER BY Duree ASC 
LIMIT 10;


select title,datediff(R.return_date,R.rental_date) 
from film as F
join inventory as I on F.film_id = I.film_id
join rental as R on I.inventory_id = R.inventory_id
where datediff(R.return_date,R.rental_date)  IS NOT NULL
ORDER BY datediff(R.return_date,R.rental_date) 
LIMIT 10;


--6
#Lister les films de la catégorie « Action » ordonnés par ordre alphabétique.


SELECT F.title FROM film as F
JOIN film_category as FC on FC.film_id = F.film_id
JOIN category as C on FC.category_id = C.category_id
WHERE C.name = 'action'
ORDER BY F.title;


--7
#Quel sont les films dont la duré d’emprunt à été inférieur à 2 jour
SELECT distinct f.title,datediff(r.return_date,r.rental_date)
FROM film as f 
JOIN inventory as i on f.film_id = i.film_id
JOIN rental as r on i.inventory_id = r.inventory_id 
WHERE datediff(r.return_date, r.rental_date)<2
and datediff(r.return_date, r.rental_date) is not null;

2nd way

#Quel sont les films dont la duré d’emprunt à été inférieur à 2 jour ?
SELECT DISTINCT F.title 
FROM rental AS RE
INNER JOIN inventory AS INV ON INV.inventory_ID=RE.inventory_id 
INNER JOIN film AS F ON F.film_id=INV.film_id
WHERE TIMESTAMPDIFF(MINUTE, RE.rental_date, RE.return_date) <= 2880;

