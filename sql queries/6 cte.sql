select * from tblEmployee;
select * from tblDepartment;

select DepartmentId, count(*) as TotalEmployee from tblEmployee group by DepartmentId;

-------------------------------------------------- CTE -------------------------------------------------------
-- create CTE
with EmployeeCount(DepartmentId, TotalEmployee)
as
(
	select DepartmentId, count(*) as TotalEmployee from tblEmployee group by DepartmentId
)					-- don't close cte with semicolon
-- select * from EmployeeCount
-- need to run EmployeeCount with its definition ; can't run separatelyu as stored proc or views
-- use CTE in a query
select DeptName, TotalEmployee from tblDepartment join EmployeeCount on tblDepartment.DeptId = EmployeeCount.DepartmentId order by TotalEmployee;


---------------------------------------------- UPDATE CTE -------------------------------------------------------
-- if cte is based on 1 base table then we can update it ; it will change base table data as well
with Employee_name_gender
as
(
	select id, name, gender from tblEmployee
)
select * from Employee_name_gender

update Employee_name_gender set gender='Female' where id = 1


-- if cte is based on 2 tables & update affects only 1 base table then update is allowed
with EmployeeByDepartment
as
(
	select id, name, gender, DeptName from tblEmployee join tblDepartment on tblDepartment.DeptId = tblEmployee.DepartmentId
)
--select * from EmployeeByDepartment
--update EmployeeByDepartment set gender = 'Male' where id = 1
--select * from tblEmployee
update EmployeeByDepartment set gender = 'Female', DeptName = 'IT' where id=1		-- will not update because modify needs to update multiple tables

--------------------------------------------------- RECURSIVE CTE -------------------------------------------------
create table tblEmpMang(
	EmployeeId int,
	Name varchar(100),
	ManagerId varchar(100)
)

insert into tblEmpMang values
(1,'Tom',2),
(2,'Josh',NULL),
(3,'Mike',2),
(4,'John',3),
(5,'Pam',1),
(6,'Mary',3),
(7,'James',1),
(8,'Sam',5),
(9,'Simon',1)

select * from tblEmpMang

-- self join
select Employee.Name as [Employee Name], ISNULL(Manager.Name, 'Super Boss') as [Manager Name]
from tblEmpMang Employee
left join tblEmpMang Manager
on Employee.ManagerId = Manager.EmployeeId




