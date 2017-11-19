#13. Find out the average speed of the PCs produced by maker A.

Select avg(pc.speed)
from pc
inner join product prod
on prod.model = pc.model
where prod.maker= 'A'
