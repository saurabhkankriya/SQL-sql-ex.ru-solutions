#25. Find the printer makers also producing PCs with the lowest RAM capacity and the highest processor speed of all PCs having the lowest RAM capacity. 

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
