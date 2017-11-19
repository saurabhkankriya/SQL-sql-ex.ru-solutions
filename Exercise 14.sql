#14.Get the makers who produce only one product type and more than one model.

select maker,type
from product
where maker in

(
select maker
from
(
select maker,type,count(type) 'c'
from product
group by maker,type
)a
group by maker
having count(maker)=1
)
group by maker,type
having count(model)>1
```
**Solution 2:**
```sql
select distinct maker,type
from product
where maker in
(
select distinct maker 
from product 
group by maker
having (count(model) > 1 and count(distinct type) =1)
)
