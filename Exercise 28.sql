#28. Using Product table, find out the number of makers who produce only one model.

select count(*)
from
(select maker
from product
group by maker
having count(model)=1
) as res
