# SQL-sql-ex.ru-solutions
##Contains approach I used and the solutions to exercises on http://www.sql-ex.ru/

1. Find the model number, speed and hard drive capacity for all the PCs with prices below $500. 
**Solution:**
```sql
Select model, speed, hd 
from PC 
where price < 500
```

2. List all printer makers.
**Solution:**
```sql
select distinct maker  
from product 
where type='Printer'
```

3. Find the model number, RAM and screen size of the laptops with prices over $1000.
**Solution:**
```sql
Select model, ram, screen
from laptop
where price > 1000
```

4. 
**Solution:**
```sql
select * from printer
where color = 'y'
```

5. 
**Solution:**
```sql
Select model, speed, hd
from PC
where price < 600 and  (cd = '12x' or cd= '24x')
```

6. 
**Solution:**
```sql
Select distinct p.maker, speed 
from laptop l
inner join product p
on l.model = p.model
where hd >= 10.0
```

7. 
**Solution:**
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

8.
**Solution:**
```sql
select maker from product where type = 'PC'
except
select maker from product where type= 'Laptop'
```

9. 
**Solution:**
```sql
Select distinct prod.maker 
from product prod
inner join pc
on prod.model = pc.model
where pc.speed >= 450
```

10. 
**Solution:**
```sql
Select model, price
from printer 
where price = (select top 1 price from printer order by price desc)
```
11. 
**Solution:**
```sql
Solution:
Select avg(speed)
from pc
```

12. 
**Solution:**
```sql
Select avg(speed)
from laptop
where price > 1000
```

13. 
**Solution:**
```sql
Select avg(pc.speed)
from pc
inner join product prod
on prod.model = pc.model
where prod.maker= 'A'
```

14. 
**Solution `:**
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

15.
**Solution:**
```sql
select hd
from pc 
group by hd
having count(hd) >= 2
```

16. 
**Solution:**
```sql
select distinct p1.model,p2.model,p1.speed,p1.ram 
from PC as p1 inner join PC as p2
on p1.model<>p2.model
where
p1.speed=p2.speed and p1.ram=p2.ram
and p1.model > p2.model
```

17. 
**Solution:**
```sql
select distinct p.type, l.model, l.speed
from product p
inner join laptop l
on p.model = l.model
where p.type= 'Laptop' and
l.speed < (select min(speed) from pc)
```

18.
**Solution:**
```sql
select distinct product.maker, printer.price
from product 
inner join printer
on product.model= printer.model
where printer.price =  (select min(price) from printer where printer.color='y')
and printer.color='y'
```

19. 
**Solution:**
```sql
Select product.maker, avg(laptop.screen)
from product
inner join laptop
on product.model = laptop.model
group by product.maker
```

20.
**Solution:**
```sql
Select maker, count(type)
from product 
where type='PC'
group by maker
having count(type) >=3
```

21. 
**Solution:**
```sql
select product.maker, max(pc.price)
from pc
inner join product
on pc.model = product.model
group by product.maker
```

22.
**Solution:**
```sql
select speed, avg(price)
from pc 
where pc.speed > 600
group by speed
```

23. 
**Solution:**
```sql
Solution:
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

24. 
**Solution:**
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

25. 
**Solution:**
```sql
select distinct maker from product 
where type ='Printer' 

intersect 

select distinct maker from product inner join PC on product.model=pc.model 
where type='PC'and  pc.speed in (select max(speed) from pc where ram=(select min(ram)from pc))and pc.ram=(select min(ram)from pc)
```
