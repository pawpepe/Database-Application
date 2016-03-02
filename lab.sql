-- Manager Report LAB
-- Anna Paula P. Maule 
-- ID: 007389344

-- Formating should be done after the SQL statement
-- Enviroment Setup 
store SET %homepath%\mySets REPLACE 
SET pagesize 60
SET linesize 100
SET feedback OFF
set newpage 0

-- cleaning previous setup because you dont know what is in there 
clear break
clear comput
clear col 

break ON manager skip page -  -- DASH mean " this is continuation of this command " ; " you set multiple breaks , the breaks are trigger by the change of the manager value/id"
	  ON mgr nodup 			  -- whenever the id manager changes compute a break 
	  
-- whatever we have a break on manager it will compute the value of the salary 
compute sum label 'Total' of salary on mgr 
compute avg 'Avarage' of comm on mgr 

ttittle center 'Manager:' mgr RIGHT _date skip 2 
btittle center sql.pno 

col manager noprint new_val mgr 
col employee FORMAT a30		    heading Employee 
col salary   FORMAT $999,999.00 heading Salary -- salary will show the heading like 'Salary'
col comm     FORMAT  0.00 		heading % jus center -- justify center 
col department					heading Department 

-- set termout off  -- turns off the terminal 
-- spool is a text file on the disk, it is where your output is going to go
spool %homepath%\ManagerReport 



-- Start first doing the SQL statement 
SELECT e.Manager_ID mgr, e.last_name || ', ' || e.first_name Employee, e.salary, 
		nvl(e.commission_pct, 0.00) comm, -- nvl : if there is no value just print "0.00"
		decode(e.manager_id, null, 'I don''t work for anybody', m.last_name || ', ' || m.first_name) manager,  -- decode id an oracle function , will take a value (manager id) , if it is null will show the mensages, last_name and first name 
		decode(d.department_id, null, 'I got no department', d.department_name) Dept 
FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id 
				 LEFT JOIN employees m   ON m.employee_id = e.manager_id  -- LEFT JOIN take the table to the most left side and selects everything , those values that dont match with the next table will be marked as null. 
				 ORDER BY e.manager_id nulls FIRST , e.last_name, d.department_id
/

-- The comments below will clean all the setups defined in the beggining of this script 
spool OFF
ttitle off  
btitle off 
cle break 
cle comp
cle buff 
cle col 
@%homepath%\mySets