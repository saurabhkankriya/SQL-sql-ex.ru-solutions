#18. Find the makers of the cheapest color printers.

select distinct product.maker, printer.price
from product 
inner join printer
on product.model= printer.model
where printer.price =  (select min(price) from printer where printer.color='y')
and printer.color='y'
