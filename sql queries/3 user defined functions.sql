select * from persons

-------------------------------------------- CHECK FUNCTIONS LOCATION---------------------------------
/*
	DB --> PROGRAMMABILITY --> FUNCTIONS --> TABLE VALUES ; SCALAR
*/
------------------------------------------------ CREATE A SCALAR FUNCTION ------------------------------------------------
-- on the basis of id find the full name
create function fn_GetFullName(@Id int)
returns varchar(100)
as
begin
	declare @fullName varchar(100)
	select @fullName = firstname + ' ' + lastname from persons where personid = @Id

	return @fullName

end

-- call function for id = 4
select * from persons
select dbo.fn_GetFullName(4)

-- call function within a query
select *, dbo.fn_GetFullName(personid) as FullName from persons




------------------------------------------------ CREATE TABLE VALUED FUNCTION ------------------------------------------------
-- if i search for male, function will return table data with male as gender
create function fn_GetData(@Gender varchar(100))
returns table
as
return										-- return is used instead of begin
(
	select * from persons where gender = @Gender
)


-- call function for male gender
select * from persons
select * from dbo.fn_GetData('female')		-- call it as a table not directly value similar to scalar