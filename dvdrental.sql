SELECT * FROM customer; 
SELECT * FROM rental; 
SELECT * FROM city; 

-- Which customers live in the city 'Haldia'?
-- ANSI join syntax 

SELECT cu.customer_id, cu.first_name, cu.last_Name, ci.city_id, ci.city 
FROM customer cu 
JOIN address ad ON cu.address_id = ad.address_id 
JOIN city ci ON ad.city_id = ci.city_id 
WHERE ci.city = 'Haldia'; 

-- equi join / inner join 
-- left inner join 
-- right inner join 
-- full inner join 

SELECT * FROM customer; 

commit; 



