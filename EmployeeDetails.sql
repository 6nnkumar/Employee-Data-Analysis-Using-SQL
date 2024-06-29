SELECT * FROM new_schema.employeedetails;
Insert into employeedetails(EmpID, FUllName, ManagerID, DateOfJoining, City) values(121,"JohnSnow", 321, '2019-01-31',"Toronto");
Insert into employeedetails(EmpID, FUllName, ManagerID, DateOfJoining, City) values(321,"WalterWhite", 986, '2019-01-30',"California");
Insert into employeedetails(EmpID, FUllName, ManagerID, DateOfJoining, City) values(421,"Kuldeep Rana", 876, '2021-11-27',"New Delhi");

select * from employeesalary;
Insert Into employeesalary(EmployeeID, Project, Salary, Variable) values(121, "p1", 8000,500);
Insert Into employeesalary(EmployeeID, Project, Salary, Variable) values(421, "p1", 12000,0);
Insert Into employeesalary(EmployeeID, Project, Salary, Variable) values(321,"p2", 10000,1000);
Insert Into employeesalary(EmpID, Project, Salary, Variable) values(00,"X", 0,0);

 ALTER TABLE employeesalary RENAME COLUMN EmployeeID to EmpID;
 UPDATE employeesalary
SET EmpID = 121 
WHERE EmpID = 00;
delete from employeesalary where EmpID = 00;
 
 
-- 1. Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’. 
    select * from employeedetails where ManagerID = 986;
    
-- 2. Write an SQL query to fetch the different projects available from the EmployeeSalary table.
      select distinct project from employeesalary;
      
-- 3. Write an SQL query to fetch the count of employees working in project ‘P1’.
       select count(EmployeeID) from employeesalary where Project = 'p1';
       
-- 4. Write an SQL query to find the maximum, minimum, and average salary of the employees.
        select min(salary) as Min_Salary, max(salary)as Max_Salary, avg(salary) as Avg_Salary from employeesalary;

-- 5. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.
        select EmployeeID, salary  from employeesalary where salary between 9000 and 15000;
        
-- 6. Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.
       select * from employeedetails where city = "Toronto" and ManagerID = 321;
       
-- 7. Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321.
       select * from employeedetails where city = "California" OR  ManagerID = 321;
       
-- 8. Write an SQL query to fetch all those employees who work on Projects other than P1.

       SELECT employeedetails.EmpID, employeedetails.FullName, employeesalary.project from employeedetails join employeesalary
         on employeedetails.EmpID = employeesalary.EmpID 
            where not project = "p1";
            
-- 9.  Write an SQL query to display the total salary of each employee adding the Salary with Variable value.
         select EmpID, sum(salary + Variable) as Total_salary from employeesalary group by EmpID;
     
-- 10.  Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters.
          select * from employeedetails where FullName like "__hn%";
          
-- 11. Write an SQL query to fetch all the EmpIds which are present in either of the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’.
     
	    select EmpID from employeedetails
          union                                   -- UNION gives the unique values from both the tables
	        select EmpID from employeesalary;

-- 12. Write an SQL query to fetch common records between two tables.
         
            -- select EmpID from employeedetails
		--      Intersect                                   -- Intersect gives the Common values from both the tables. Since it not works
	      --  select EmpID from employeesalary;
            
             select * from employeedetails
              where EmpID in (select EmpID from employeesalary);
              
-- 13. Write an SQL query to fetch records that are present in one table but not in another table.

            select * from employeedetails Left join employeesalary
               on employeedetails.EmpID = employeesalary.EmpID;
               
-- 14. Write an SQL query to fetch the employee’s full names and replace the space with ‘-’

		 select replace(FullName, " ", "-") from employeedetails;    -- While adding data, i did not gave space on full name, So the output will not come
            
-- 15.  Write an SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary.
             SELECT 
    *
FROM
    employeedetails
WHERE
    EmpID NOT IN (SELECT 
            EmpID
        FROM
            employeesalary);
                
-- 16. Write an SQL query to fetch the position of a given character(s) in a field.
              select FullName, instr(FullName, "h") as Position from employeedetails;     -- instr() gives the positio of the particular text
                
-- 17. Write an SQL query to display both the EmpId and ManagerId together.
          select concat(EmpID," ", ManagerID) from employeedetails;

-- 18. Write a query to fetch only the first name(string before space) from the FullName column of the EmployeeDetails table.
        SELECT LEFT(FullName, INSTR(FullName, ' ') - 1) AS FirstName
          FROM EmployeeDetails;
          
-- 19. Write an SQL query to uppercase the name of the employee and lowercase the city values.
         select upper(FullName), lower(city) from employeedetails;
         

-- 20. Write an SQL query to find the count of the total occurrences of a particular character – ‘n’ in the FullName field.
     SELECT FullName, LENGTH(FullName) - LENGTH(REPLACE(FullName, 'n', '')) FROM EmployeeDetails ;
     
-- 21. Write an SQL query to update the employee names by removing leading and trailing spaces.
       UPDATE EmployeeDetails 
           SET FullName = LTRIM(RTRIM(FullName));
           
-- 22. Fetch all the employees who are not working on any project.
          SELECT EmpId FROM EmployeeSalary WHERE Project IS NULL;
          
-- 23. Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and less than or equal to 10000.
         
            select employeedetails.EmpID, employeedetails.FullName, employeesalary.Salary from employeedetails
                join employeesalary on employeedetails.EmpID = employeesalary.EmpID
                    where employeesalary.Salary between 5000 and 10000;
                    
-- 24. Write an SQL query to find the current date-time.
         select now();
         
-- 25. Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table.
      -- Using ‘Exists’-
      
           select employeedetails.EmpID, employeedetails.FullName
               from employeedetails
                 where exists (select EmpID from employeesalary where employeedetails.EmpID = employeesalary.EmpID);

-- 26. Write an SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2019.
             select * from employeedetails where DateOfJoining between '2019-01-01' and '2019-12-31';
             
-- 27. Write an SQL query to fetch the project-wise count of employees sorted by project’s count in descending order.
         select Project, count(EmpID) as Emp_Count from employeesalary group by project order by Emp_Count desc;
         
-- 28.  Write a query to fetch employee names and salary records. Display the employee details even if the salary record is not present for the employee.
         select employeedetails.EmpID, employeedetails.FullName, employeedetails.City,
                  employeesalary.Salary from employeedetails left Join employeesalary
                       on employeedetails.EmpID = employeesalary.EmpID;
                       
-- 29. Write an SQL query to join 3 tables.
              
            SELECT 
    column1, column2
FROM
    TableA
        JOIN
    TableB ON TableA.Column3 = TableB.Column3
        JOIN
    TableC ON TableA.Column4 = TableC.Column4;

-- 30. Write an SQL query to fetch all the Employees who are also managers from the EmployeeDetails table.
        select E.EmpID, E.FullName
          from employeedetails E Inner join employeedetails F
            on E.EmpID = F.ManagerID;

-- 31. Write an SQL query to fetch duplicate records from EmployeeDetails (without considering the primary key – EmpId).
           SELECT FullName, ManagerId, DateOfJoining, City, count(*)
                   FROM EmployeeDetails
                     GROUP BY FullName, ManagerId, DateOfJoining, City
                        HAVING COUNT(*) > 1;
                        
-- 32. Write an SQL query to remove duplicates from a table without using a temporary table.
               DELETE E1 FROM EmployeeDetails E1
INNER JOIN EmployeeDetails E2 
WHERE E1.EmpId > E2.EmpId 
AND E1.FullName = E2.FullName 
AND E1.ManagerId = E2.ManagerId
AND E1.DateOfJoining = E2.DateOfJoining
AND E1.City = E2.City;

-- 33. Write an SQL query to fetch only odd rows from the table.
            SELECT * FROM EmployeeDetails WHERE MOD (EmpId, 2) <> 0;
               
                                         --    OR   (incase empID is not there in table, we can create  row no to rows)
			SELECT E.EmpId, E.Project, E.Salary
              FROM (
                  SELECT *, Row_Number() OVER(ORDER BY EmpId) AS RowNumber
				FROM EmployeeSalary
                   ) E
                     WHERE E.RowNumber % 2 = 1;
-- 34. Write an SQL query to fetch only Even rows from the table.
         SELECT * FROM EmployeeDetails  WHERE MOD (EmpId, 2) = 0;
         
-- 35.  Write an SQL query to create a new table with data and structure copied from another table
        create table CopyTable select * from employeedetails;    -- To create a whole table
        select * from copytable;
        create table RowTable like employeedetails;
		select * from RowTable;                                  -- To create table by exact copy rows from another table
        
-- 36. Write an SQL query to fetch top n records.
         select * from employeedetails order by EmpID desc limit 1;
                         -- OR
		--  select Top 1 * from employeedetails;
         
-- 37. Write SQL query to find the 3rd highest salary from a table without using the TOP/limit keyword.

        select * from (select salary, row_number() over(order by salary desc) as  Rank from employeesalary) as Sub_Query from employeedetails where  row_number = 3;
        
-- 38. Consider a SalesData with columns SaleID, ProductID, RegionID, SaleAmount. Write a query to find the total sales amount for each product in each region.

            SELECT ProductID, RegionID, SUM(SaleAmount) AS TotalSales 
              FROM SalesData 
                 GROUP BY ProductID, RegionID;
                 
-- 39. Write a query to find employees who earn more than their managers.
           SELECT E.FullName AS EmployeeName, 
E.Salary AS EmployeeSalary, 
M.Salary AS ManagerSalary 
FROM EmployeeDetails E JOIN EmployeeDetails M 
ON E.ManagerID = M.EmployeeID 
WHERE E.Salary > M.Salary;

-- 40.  Consider a BookCheckout table with columns – CheckoutID, MemberID, BookID, CheckoutDate, ReturnDate.
         --  Write an SQL query to find the number of books checked out by each member.

                   SELECT MemberID, COUNT(*) AS NumberOfBooksCheckedOut 
                    FROM BookCheckout 
                      GROUP BY MemberID;
                      
-- 41. Consider a StudentGrades table with columns – StudentID, CourseID, Grade. Write a query to find students who have scored an ‘A’ in more than three courses.
	-- Here we will write an SQL query that filters students who have received an ‘A’ grade and groups them by StudentID, counting the number of ‘A’ grades per student.


select EmpID, max(DateOfJoining) from employeedetails group by EmpID;


          
