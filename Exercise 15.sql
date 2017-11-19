#15. Get hard drive capacities that are identical for two or more PCs. 

select hd
from pc 
group by hd
having count(hd) >= 2
