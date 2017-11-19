#16. Get pairs of PC models with identical speeds and the same RAM capacity. Each resulting pair should be displayed only once, i.e. (i, j) but not (j, i). 

select distinct p1.model,p2.model,p1.speed,p1.ram 
from PC as p1 inner join PC as p2
on p1.model<>p2.model
where
p1.speed=p2.speed and p1.ram=p2.ram
and p1.model > p2.model
