#23. Get the makers producing both PCs having a speed of 750 MHz or higher and laptops with a speed of 750 MHz or higher. 

select product.maker 
from product 
inner join pc
on product.model = pc.model
where pc.speed >= 750
intersect
select product.maker 
from product 
inner join laptop
on product.model = laptop.model
where laptop.speed >= 750
