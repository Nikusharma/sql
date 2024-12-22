select * from persons

-------------------------------------------------- CREATE PROC --------------------------------------------------
create procedure spGetNames		-- create proc can also be used
as
begin
	select firstName, lastName from persons
end

-- call proc
spGetNames
exec spGetNames
Execute spGetNames


-------------------------------------------------- CREATE PROC WITH INPUT PARAMETERS --------------------------------------------------
-- give names of males with rank = 98
create proc spGetEmplByGenderAndRank
@Gender varchar(100), @Rank int			-- id i use declare here it will give error
as
begin
	select * from persons where gender = @Gender and rank_no = @Rank
end

-- exec sp with variables
spGetEmplByGenderAndRank 'Male',98
spGetEmplByGenderAndRank @Rank = 98, @Gender='Male'

-- helptext - to give definition of store proc
sp_helptext spGetEmplByGenderAndRank

-- alter stored proc
alter proc spGetEmplByGenderAndRank
@Gender varchar(100), @Rank int
as
begin
	select * from persons where gender = @Gender and rank_no = @Rank order by phone desc
end

-- run altered store proc
spGetEmplByGenderAndRank @Rank = 98, @Gender='Male'

-- drop proc
-- drop proc spGetEmplByGenderAndRank

--------------------------------------------------- ENCRYPT ----------------------------------------------
alter proc spGetEmplByGenderAndRank
@Gender varchar(100), @Rank int
WITH Encryption
as
begin
	select * from persons where gender = @Gender and rank_no = @Rank
end

-- can't see definition now
sp_helptext spGetEmplByGenderAndRank

-- data is still visible
spGetEmplByGenderAndRank @Rank = 98, @Gender='Male'

-------------------------------------------------- CREATE PROC WITH OUTPUT PARAMETERS --------------------------------------------------
-- create proc
create proc spGetEmplCount
@Gender varchar(100), @EmplCount int output
as
begin
	select @EmplCount = count(personid) from persons where gender = @Gender
end

-- run proc
select * from persons

declare @TotalCount int 
exec spGetEmplCount 'Male', @TotalCount out			-- can use output as well
print @TotalCount

-- run proc again
declare @TotalCount int
exec spGetEmplCount 'Male', @TotalCount out 
if(@TotalCount is null)
	print '@TotalCount is null'
else
	print '@TotalCount is not null'

print @TotalCount


-------------------------------------------------- USING RETURN VALUES --------------------------------------------------
-- create proc 
create proc spGetTotalCount2
as
begin
	return (select count(personid) from persons)
end

-- run proc
declare @Total int
exec @Total = spGetTotalCount2 
print @Total
-------------------------------------------------- HELP --------------------------------------------------

sp_helptext spGetEmplCount		-- gives definition
sp_help spGetEmplCount			-- view info like parameters, datatypes
sp_depends spGetEmplCount		-- shows dependencies, if any store proc is referencing a table

