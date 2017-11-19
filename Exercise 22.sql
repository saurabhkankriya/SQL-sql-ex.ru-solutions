#22. For each value of PC speed that exceeds 600 MHz, find out the average price of PCs with identical speeds.

select speed, avg(price)
from pc 
where pc.speed > 600
group by speed
