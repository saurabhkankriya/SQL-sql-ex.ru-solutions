# sql-ex.ru Solutions
---------------------
### Contains SQL solutions to exercises on [sql-ex.ru](http://www.sql-ex.ru)

1. Find the model number, speed and hard drive capacity for all the PCs with prices below $500. 
```sql
Select model, speed, hd 
from PC 
where price < 500
```

2. List all printer makers.
```sql
select distinct maker  
from product 
where type='Printer'
```

3. Find the model number, RAM and screen size of the laptops with prices over $1000.
```sql
Select model, ram, screen
from laptop
where price > 1000
```

4. Find all records from the Printer table containing data about color printers.
```sql
select * from printer
where color = 'y'
```

5. Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x CD drive.
```sql
Select model, speed, hd
from PC
where price < 600 and  (cd = '12x' or cd= '24x')
```

6. For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops.
```sql
Select distinct p.maker, speed 
from laptop l
inner join product p
on l.model = p.model
where hd >= 10.0
```

7. Get the models and prices for all commercially available products (of any type) produced by maker B.
```sql
select pri.model, pri.price from printer pri
inner join product prod
on pri.model = prod.model
where prod.maker = 'B'
 
union

select l.model, l.price from laptop l
inner join product prod
on l.model = prod.model
where prod.maker = 'B'

union
select pc.model, pc.price from pc 
inner join product prod
on pc.model = prod.model
where prod.maker = 'B'
```

8. Find the makers producing PCs but not laptops.
```sql
select maker from product where type = 'PC'
except
select maker from product where type= 'Laptop'
```

9. Find the makers of PCs with a processor speed of 450 MHz or more. 
```sql
Select distinct prod.maker 
from product prod
inner join pc
on prod.model = pc.model
where pc.speed >= 450
```

10. Find the printer models having the highest price. 
```sql
Select model, price
from printer 
where price = (select top 1 price from printer order by price desc)
```

11. Find out the average speed of PCs.
```sql
Solution:
Select avg(speed)
from pc
```

12. Find out the average speed of the laptops priced over $1000.
```sql
Select avg(speed)
from laptop
where price > 1000
```

13. Find out the average speed of the PCs produced by maker A.
```sql
Select avg(pc.speed)
from pc
inner join product prod
on prod.model = pc.model
where prod.maker= 'A'
```

14.Get the makers who produce only one product type and more than one model.
```sql
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
```

15. Get hard drive capacities that are identical for two or more PCs. 
```sql
select hd
from pc 
group by hd
having count(hd) >= 2
```

16. Get pairs of PC models with identical speeds and the same RAM capacity. Each resulting pair should be displayed only once, i.e. (i, j) but not (j, i). 
```sql
select distinct p1.model,p2.model,p1.speed,p1.ram 
from PC as p1 inner join PC as p2
on p1.model<>p2.model
where
p1.speed=p2.speed and p1.ram=p2.ram
and p1.model > p2.model
```

17. Get the laptop models that have a speed smaller than the speed of any PC. 
```sql
select distinct p.type, l.model, l.speed
from product p
inner join laptop l
on p.model = l.model
where p.type= 'Laptop' and
l.speed < (select min(speed) from pc)
```

18. Find the makers of the cheapest color printers.
```sql
select distinct product.maker, printer.price
from product 
inner join printer
on product.model= printer.model
where printer.price =  (select min(price) from printer where printer.color='y')
and printer.color='y'
```

19. For each maker having models in the Laptop table, find out the average screen size of the laptops he produces. 
```sql
Select product.maker, avg(laptop.screen)
from product
inner join laptop
on product.model = laptop.model
group by product.maker
```

20. Find the makers producing at least three distinct models of PCs.
```sql
Select maker, count(type)
from product 
where type='PC'
group by maker
having count(type) >=3
```

21. Find out the maximum PC price for each maker having models in the PC table.
```sql
select product.maker, max(pc.price)
from pc
inner join product
on pc.model = product.model
group by product.maker
```

22. For each value of PC speed that exceeds 600 MHz, find out the average price of PCs with identical speeds.
```sql
select speed, avg(price)
from pc 
where pc.speed > 600
group by speed
```

23. Get the makers producing both PCs having a speed of 750 MHz or higher and laptops with a speed of 750 MHz or higher. 
```sql
select product.maker 
from product 
inner join pc
on product.model = pc.model
where pc.speed >= 750
intersect
select product.maker 
from product 
inner join laptop
on product.model = laptop.model
where laptop.speed >= 750
```

24. List the models of any type having the highest price of all products present in the database.
```sql
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
```

25. Find the printer makers also producing PCs with the lowest RAM capacity and the highest processor speed of all PCs having the lowest RAM capacity. 
```sql
select distinct maker from product 
where type ='Printer' 

intersect 

select distinct maker from product inner join PC on product.model=pc.model 
where type='PC'and  
pc.speed in 
          (select max(speed) 
           from pc 
           where ram=
                     (select min(ram)from pc)
           )
 and pc.ram=
             (select min(ram)
              from pc)
```
26. Find out the average price of PCs and laptops produced by maker A.
```sql
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
```
27. Find out the average hard disk drive capacity of PCs produced by makers who also manufacture printers.
```sql
select product.maker, avg(pc.hd ) as Avg_hd
from pc
inner join product
on pc.model = product.model
where maker in 
(select maker from product where type='Printer')
group by product.maker
```
