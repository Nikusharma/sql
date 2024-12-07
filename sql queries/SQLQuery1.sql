create database test_db;

create table persons(
	personid int,
	lastname varchar(255),
	firstname varchar(255),
	city varchar(255),
	phone int
);

insert into persons values
(1, 'l1' , 'f1', 'a1', 12345),
(2, 'l2', 'f2', 'a2', 23456),
(3, 'l3', 'f3', 'a3', 34567),
(4, 'l4', 'f4', 'a4', 45678),
(5, 'l5', 'f5', 'a5', 56789);

select * from persons;

alter table persons add rank_no int
alter table persons add profit int

 -- insert into persons (rank_no) values (98) where personid = 1
update persons set profit = -700 where personid =1
update persons set profit = 800 where personid =2
update persons set profit = -200 where personid =3
update persons set profit = 0 where personid =4
update persons set profit = -500 where personid =5

select * from persons;
select *, rank() over (order by rank_no desc) as rank_output from persons;

select * from persons;
select *, dense_rank() over(order by rank_no desc) as dense_rank_output from persons;

select * from persons;
select *, percent_rank() over(order by rank_no desc) as percent_rank_output from persons;

select * from persons;
select *, row_number() over(order by rank_no desc) as row_number_output from persons;


select *, 
rank() over(order by rank_no desc) as rank_output,
dense_rank() over(order by rank_no desc) as dense_rank_output,
percent_rank() over(order by rank_no desc) as percent_rank_output,
row_number() over(order by rank_no desc) as row_number_output
from persons;

select *,
rank() over w as rank_output,
dense_rank() over w as dense_rank_output,
percent_rank() over w as percent_rank_output,
row_number() over w as row_number_output
from persons
window w as (order by rank_no desc);


select * from persons;
select *, lead(profit,1,0) over(order by personid) as next_profit,
lag(profit,1,0) over(order by personid) as previous_profit 
from persons;




DELIMITER $$

CREATE FUNCTION profitType(profit int)
RETURNS VARCHAR(30) DETERMINISTIC

BEGIN
DECLARE message VARCHAR(30)
IF profit <= -500 THEN
	SET message = 'Huge Loss';
ELSEIF profit BETWEEN -500 AND 0 THEN
	SET message = 'Bearable Loss';
ELSEIF profit BETWEEN 0 AND 500 THEN
	SET message = 'Decent Profit';
ELSE
	SET message = 'Great Profit';
END IF;

RETURN message;

END;

$$ 
DELIMITER;