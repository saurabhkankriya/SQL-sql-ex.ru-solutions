#21. Find out the maximum PC price for each maker having models in the PC table.

select product.maker, max(pc.price)
from pc
inner join product
on pc.model = product.model
group by product.maker
