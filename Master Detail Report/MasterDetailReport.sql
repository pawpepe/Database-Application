--Anna Paula Pawlicka Maule 
--CSU ID#07389344 
-- Formating should be done after the SQL statement
-- Enviroment Setup 
store SET %homepath%\mySets REPLACE 
SET pagesize 50  
SET linesize 90    
SET feedback OFF   
set newpage 2

col today new_value curdate 
col Customer new_val name
col order_id new_value order_number
col Manager new_value manager_name 
col order_total new_value total
-- cleaning previous setup because you dont know what is in there 
clear break
clear comput
clear col 

break ON customer skip page    
	 -- ON blnk                   
	  
-- whatever we have a break on customer it will compute the value of Total sum of the extension

compute sum label'Total' of Extension on blnk

ttitle  center '========================================================'  skip 4 -
   center 'Invoice' skip 2-
   center 'Customer: ' name skip-  
   center 'Order #: ' order_number skip -
   center 'Manager: ' manager_name skip -
   center 'Purchase Total: ' FORMAT $999,999.00 total skip-
   uline skip 2
   
btitle Left curdate center 'TechCompany' RIGHT sql.user SQL.PNO skip 2 
  



col Customer new_val name
col today new_value curdate
col order_id new_value order_number
col Manager new_value manager_name 
col order_total new_value total
col line_item_id    		heading 'Line| Number' 
col product_id     	 	    heading 'Product|Number' 
col product_name    FORMAT a20     	heading 'Product Name'
col quantity        		            heading 'Quantity'  
col unit_price		FORMAT $999,999.00	heading 'Price'
col Extension		FORMAT $999,999.00  heading 'Total' 
col order_id noprint
col Customer noprint 
col Manager noprint 
col order_total noprint 
col xline new_value uline 

--col blnk					    heading ' '
col uline new_value uline  

set termout  --display/don't display script file output to the screen 
select to_char(sysdate,'fmDay dd Month yyyy') today from dual; 
select lpad('',66,'=') xline from dual; 


-- set termout off  -- turns off the terminal 
-- spool is a text file on the disk, it is where your output is going to go
spool %homepath%\ManagerReport 

-- SQL STATEMENT ---------

SELECT   line_item_id, product_id, product_name, order_id,  Quantity,order_total, unit_price, unit_price * quantity as Extension, cust_first_name|| ' ,' || cust_last_name as Customer, m.first_name || ', ' ||m.last_name as Manager
	from order_items join Orders o using (order_id)
					 Join Customers using (customer_id)
					 Join Products using (product_id)
	                 Join Employees e on e.employee_id = o.sales_rep_id
	                 Join Employees m on e.manager_id = m.employee_id
	Order by Order_id asc, line_item_id
	/
				
				
-- The comments below will clean all the setups defined in the beggining of this script 
spool OFF
ttitle off  
btitle off 
cle break 
cle comp
cle buff 
cle col 
undef curdate 
undef uline
undef name
undef order_number
undef total
undef manager_name
@%homepath%\mySets
				
				

