#17. Get the laptop models that have a speed smaller than the speed of any PC. 

select distinct p.type, l.model, l.speed
from product p
inner join laptop l
on p.model = l.model
where p.type= 'Laptop' and
l.speed < (select min(speed) from pc)
