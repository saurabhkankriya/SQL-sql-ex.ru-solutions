#27. Find out the average hard disk drive capacity of PCs produced by makers who also manufacture printers.

select product.maker, avg(pc.hd ) as Avg_hd
from pc
inner join product
on pc.model = product.model
where maker in 
(select maker from product where type='Printer')
group by product.maker
