#9. Find the makers of PCs with a processor speed of 450 MHz or more. 

Select distinct prod.maker 
from product prod
inner join pc
on prod.model = pc.model
where pc.speed >= 450
