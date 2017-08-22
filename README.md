# SQL-sql-ex.ru-solutions
Contains approach I used and the solutions to exercises on http://www.sql-ex.ru/

1. Select model, speed, hd from PC where price < 500

2. select distinct maker 
from product 
where type='Printer'

3. Select model, ram, screen
from laptop
where price > 1000

4. select * from printer
where color = 'y'

5. Select model, speed, hd
from PC
where price < 600 and  (cd = '12x' or cd= '24x')

6. Approach: 
1. First query the laptop table to find model and speed that have capacity greater than or equal to 10.
select model, speed from laptop
where hd>= 10.0
2. Take a look at database architecture. There is a join on 'model' between the product and the laptop table. Use the maker from the product table using join on the model id:

Solution: 
Select distinct p.maker, speed 
from laptop l
inner join product p
on l.model = p.model
where hd >= 10.0

7. Approach:
1. We need all the models and their prices manufactred by the maker B. 
2. Query the product table to know the data
3. Query to know what models are made by maker 'B'
select model 
from product 
where maker = 'B'
4. We do not know which models satisfy the criteria so we take a union with all the tables. Note: make sure column names are same but are referenced by their alias
Solution:
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


8. Approach: Straight forward quetion on Except set operation
solution:
select maker from product where type = 'PC'
except
select maker from product where type= 'Laptop'

9. Approach:
1. Reading the question gives a hint that the query will involve a join between the product and the pc table
2. First we find out makers of PC
Select maker from product where type = 'PC'
3. Using the database architetucre, we see join on model

Solution:
Select distinct prod.maker 
from product prod
inner join pc
on prod.model = pc.model
where pc.speed >= 450


10. Approach:
1. This query does require knowledge of subqueries. 
2. We will first select the highest price of printer. The order by clause will sort the price from the descending order and top 1 will select the highest price:
select top 1 price from printer order by price desc
3. Now we need to make use of this result in the outer query. We will use this resultset in the where clause with = and for this we will select mode and price:
Select model, price
from printer 
where price = (select top 1 price from printer order by price desc)

11. Approach:
1. This is clearly a example of aggregate function avg
Solution:
Select avg(speed)
from pc
Note: As we are summarizing only one column, we need not use group by clause


12. 
Approach same as above. Only thing added is the where clause:
Solution:
Select avg(speed)
from laptop
where price > 1000


13. 
Approach same as above. Another thing added is the join condition as we need to refer the maker 'A' from product table. Refer the database architecture:
Solution:
Select avg(pc.speed)
from pc
inner join product prod
on prod.model = pc.model
where prod.maker= 'A'


14. 
Solution 1 :
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

Solution 2:
select distinct maker,type
from product
where maker in
(
select distinct maker 
from product 
group by maker
having (count(model) > 1 and count(distinct type) =1)
)


15. Approach:
1. Knowledge of group by and having is essential for this question.  
Solution:
select hd
from pc 
group by hd
having count(hd) >= 2

16. Approach:
1. This is a tricky question and we need to break this down in steps
2. This query requires 2 columns of models with same speed and ram 
3. In the resulting pair we need to have 1st column of model greater than 2nd column of model. Also, repetition is not allowed. So in the query we will use a self join on different models
select  p1.model,p2.model,p1.speed,p1.ram 
from PC as p1 inner join PC as p2
on p1.model<>p2.model
4. Now we apply the other conditions mentioned in the problem statement
select  p1.model,p2.model,p1.speed,p1.ram 
from PC as p1 
inner join PC as p2
on p1.model<>p2.model
where
p1.speed=p2.speed and p1.ram=p2.ram
5. Now the last condition where we need 1st column model to be greater then 2nd model column
select p1.model,p2.model,p1.speed,p1.ram 
from PC as p1 
inner join PC as p2
on p1.model<>p2.model
where
p1.speed=p2.speed and p1.ram=p2.ram
and p1.model > p2.model
6. The resultant query is logically correct but might produce duplicate records. Hence we add the distinct clause in the select statement. 
Solution: 
select distinct p1.model,p2.model,p1.speed,p1.ram 
from PC as p1 inner join PC as p2
on p1.model<>p2.model
where
p1.speed=p2.speed and p1.ram=p2.ram
and p1.model > p2.model



17. Approach:
1. These query requires use of join and subquery
2. One of the clause needs speed of laptop should be less than any speed in pc. This can be obtained as speed < (select min(speed) from pc)
3. There is join on product.model = laptop.model as type will be obtained from product and laptop will give us model and speed
select distinct p.type, l.model, l.speed
from product p
inner join laptop l
on p.model = l.model
4. And the last condition is that the type should be laptop and we will use the distinct clause as it will remove the duplicates and work on other tables as well
 Solution:
select distinct p.type, l.model, l.speed
from product p
inner join laptop l
on p.model = l.model
where p.type= 'Laptop' and
l.speed < (select min(speed) from pc)

18. Approach:
1.  
Solution:
select distinct product.maker, printer.price
from product 
inner join printer
on product.model= printer.model
where printer.price =  (select min(price) from printer where printer.color='y')
and printer.color='y'

19. Approach:
1. Straighforward make use of join 
2. Select average screen size and group by maker

Solution:
Select product.maker, avg(laptop.screen)
from product
inner join laptop
on product.model = laptop.model
group by product.maker


20.
Approach:
1. We need to make use of group by (maker) and having clause (for making at least 3  types of pc
 

Solution:
Select maker, count(type)
from product 
where type='PC'
group by maker
having count(type) >=3


21. Solution:
select product.maker, max(pc.price)
from pc
inner join product
on pc.model = product.model
group by product.maker


22.
Solution:
select speed, avg(price)
from pc 
where pc.speed > 600
group by speed


23. 
Approach:
1. If you read the question carefully, you will see that the speed condition occurs in both the tables (pc and laptop). I initially tried several combinations of joined but the result was not matching.
2. There are two joins which are then combined with the intersect clause. 
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

24. 
Approach: 
1. We need to find models with highest price in all products categories. This will be a repetitive task and hence we need to make use of a cte

