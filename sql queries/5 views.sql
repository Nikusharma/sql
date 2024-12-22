create table tblDepartment(
	DeptId int,
	DeptName varchar(100)
)

create table tblEmployee(
	Id int,
	Name varchar(100),
	Salary int,
	Gender varchar(100),
	DepartmentId int
)

insert into tblDepartment values 
(1,'IT'),
(2,'Payroll'),
(3, 'HR'),
(4, 'Admin')

insert into tblEmployee values 
(1,'John',5000,'Male',3),
(2,'Mike',3400,'Male',2),
(3,'Pam',6000,'Female',1),
(4,'Todd',4800,'Male',4),
(5,'Sara',3200,'Female',1),
(6,'Ben',4800,'Male',3)

select * from tblDepartment
select * from tblEmployee

---------------------------------------------------------CREATE VIEW ------------------------------------------------------
create view vEmployeeByDeartment
as
select * from tblEmployee join tblDepartment on tblEmployee.DepartmentId = tblDepartment.DeptId

-- run view
select * from vEmployeeByDeartment

-- create another view
create view vWSummarizedData
as
select DeptName, count(Id) as TotalEmpl from tblEmployee join tblDepartment on tblDepartment.DeptId = tblEmployee.DepartmentId group by DeptName

-- run view
select * from vWSummarizedData

-- drop
drop view vWSummarizedData

------------------------------------------------------- UPDATE VIEW --------------------------------------------
select * from vEmployeeByDeartment
UPDATE vEmployeeByDeartment
set Name = 'Mikey' where Id = 2
select * from vEmployeeByDeartment
select * from tblEmployee			-- base table has also been updated

delete from vEmployeeByDeartment where Id =2		-- won't get deleted because this view is getting data from multiple base tables

create view vEmpl
as
select * from tblEmployee where Gender = 'Male'
select * from vEmpl
delete from vEmpl where Id = 2					-- deleted because dependecy on 1 base table ; also deleted from base table
select * from vEmpl						
select * from tblEmployee

insert into tblEmployee values (2,'Mike',3400,'Male',2)

------------------------------------------------------------- INDEXED VIEW -------------------------------------------------
/* view is virtual table, it doesn't store nay data by default but if we create indexed view, it gets materialised */

create table tblProduct(
	ProductId int,
	Name varchar(100),
	UnitPrice int
)

create table tblProductsales(
	ProductId int,
	QuantitySold int
)

insert into tblProduct values
(1,'Books',20),
(2,'Pens',14),
(3,'Pencils',11),
(4,'Clips',10)

insert into tblProductsales values
(1,10),(2,23),(4,21),(2,12),(1,13),(3,12),(4,13),(1,11),(2,12),(1,14)

select * from tblProduct
select * from tblProductsales

-- create view
create view vWTotalSales
WITH SCHEMABINDING
as
select p.Name, SUM(ISNULL(s.QuantitySold * p.UnitPrice,0)) as TotalSales, Count_BIG(*) as TotalTransactions 
from dbo.tblProductsales as s					-- dbo. should be mentioned otherwise will give error in schemabinding	because fully qualified names are required in schema binding
join dbo.tblProduct as p
on p.ProductId = s.ProductId
group by p.Name

select * from vWTotalSales

-- create index
create unique clustered index UIX_vWTotalSalesByProduct
on vWTotalSales(Name)
