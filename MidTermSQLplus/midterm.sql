store SET %homepath%\mySets REPLACE 

SET pagesize 30  
SET linesize 90   
SET feedback OFF
set newpage 2
set verify off 

--col today new_value curdate 
--col department_name new_val dep_name
--col city new_val city_name 
--col Name new_val employeeName 

clear break
clear comput
clear col 


break ON departmentID skip page  - 
	  ON blnk 

compute sum LABEL 'Total' OF Salary  on blnk 
	
ACCEPT id NUMBER FORMAT '9999' DEFAULT '1700' -
PROMPT 'Enter Employee ID ( 4 digit):  '
  
ttitle "================================================================================" skip 2 -
	   center 'Department: ' dep_name skip - 
	   center 'Employees in  ' city_name skip - 
	   center 'Date: ' curdate skip 2 
   
btitle center sql.pno LEFT 'Report Comapany' skip 3 - 
	"================================================================================" 

				  				  
				  

 
				  
col today new_val curdate 
col department_name new_val dep_name
col city new_val city_name 
col Name new_val employeeName 

col Name				FORMAT a23 				    heading 'Name'   
col Department_name		FORMAT a10					heading 'Department' 
col salary   			FORMAT $999,999.00          heading 'Salary'  
col Job_title			FORMAT a24					heading 'Job Title'
col blnk 				FORMAT a5					heading '  '

col job_id 			noprint 
col department_id	noprint 
col location_id		noprint 
col employee_id		noprint
col DepartmentID    noprint 
col city			noprint 

--set termout on
select to_char(sysdate,'fmDay,dd, Month ,yyyy') today from dual; 

spool %homepath%\ManagerReport 

SELECT  '    ' blnk, department_id as DepartmentID , Last_name || ' , ' || First_name as Name , Department_name, Job_title, Salary, city, job_id, location_id, employee_id
	FROM Employees join Jobs using(Job_id)
				   join Departments using(department_id)	
				   join Locations using(location_id)
				where location_id = &id
				order by department_id
				/ 
				   

spool OFF
ttitle off  
btitle off 
cle break 
cle comp
cle buff 
cle col  
undef curdate 
undef city_name 
undef dep_name

@%homepath%\mySets