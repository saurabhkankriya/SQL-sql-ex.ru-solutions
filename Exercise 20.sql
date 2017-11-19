#20. Find the makers producing at least three distinct models of PCs.

Select maker, count(type)
from product 
where type='PC'
group by maker
having count(type) >=3
