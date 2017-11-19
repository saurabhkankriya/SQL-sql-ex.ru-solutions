#8. Find the makers producing PCs but not laptops.

select maker from product where type = 'PC'
except
select maker from product where type= 'Laptop'
