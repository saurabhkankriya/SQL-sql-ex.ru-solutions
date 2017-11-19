#19. For each maker having models in the Laptop table, find out the average screen size of the laptops he produces. 

Select product.maker, avg(laptop.screen)
from product
inner join laptop
on product.model = laptop.model
group by product.maker
