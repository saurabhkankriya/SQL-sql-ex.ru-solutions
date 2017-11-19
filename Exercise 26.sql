#26. Find out the average price of PCs and laptops produced by maker A.

select avg(price)
from
(select pc.price
from pc
inner join product
on pc.model = product.model
where product.maker='A'
union all
select laptop.price
from laptop
inner join product
on laptop.model = product.model
where product.maker='A'
) res
