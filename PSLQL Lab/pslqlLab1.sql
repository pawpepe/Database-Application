create or replace porcedure plsql_lab(
		emp_id in employees.employee_id%type, 
		ref_cursor out sys_refcursor)  -- is not a direct assigment , just what is coming out 
		
as 	
		cursor try_param(dp_id number) is 
			select last_name from employees where department_id = dp_id; 
		emp_name 		employees.last_name%type; -- instead of saying VAR_CHAR(32) is gonna automatically find the type of the variable 
		dep_id			departments.department_id%type;
		dep_name		departments.department_name%type;

begin 
		select last_name, department_id, department_name, 
				into emp_name, dep_name, dep_id
				from employees
				join departments using(department_id)
				where employee_id = emp_id;
				
				dbms_output.put_line('And the winner is ' || emp_name ||
					'from department' || dep_name);
					
				for x in try_param(dep_id) loop
					dbms_output.put_line(x.last_name);
				end loop;
				
				open ref_cursor for select last_nam from employees 
					where department_id = dep_id; 

	null; 
	
end; 
/		-- good to put the slash in the end of the procedure 
sho err -- it will show the errors 

-- save the file as " .pro"
-- it does not matter the extension tyoe that is saved 


