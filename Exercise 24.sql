#24. List the models of any type having the highest price of all products present in the database.

with cte_model(model, HighPrice) as
(select model, max(price) as HighPrice
from laptop
group by model

union

select model, max(price)as HighPrice
from pc
group by model

union

select model, max(price)as HighPrice
from printer
group by model
)
select model from cte_model
where HighPrice=(select max(HighPrice) from cte_model)
