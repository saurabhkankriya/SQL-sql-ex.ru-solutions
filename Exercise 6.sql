#6. For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops.

Select distinct p.maker, speed 
from laptop l
inner join product p
on l.model = p.model
where hd >= 10.0
