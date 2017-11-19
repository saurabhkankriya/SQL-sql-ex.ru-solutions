#2. List all printer makers.

select distinct maker  
from product 
where type='Printer'
