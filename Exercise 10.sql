#10. Find the printer models having the highest price. 

Select model, price
from printer 
where price = (select top 1 price from printer order by price desc)
