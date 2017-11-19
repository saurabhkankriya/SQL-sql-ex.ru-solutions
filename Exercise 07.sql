#7. Get the models and prices for all commercially available products (of any type) produced by maker B.

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
