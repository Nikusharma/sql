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

update persons set rank_no = 98 where personid =1
update persons set rank_no = 98 where personid =2
update persons set rank_no = 98 where personid =3
update persons set rank_no = 95 where personid =4
update persons set rank_no = 94 where personid =5

update persons set profit = -700 where personid =1
update persons set profit = 800 where personid =2
update persons set profit = -200 where personid =3
update persons set profit = 0 where personid =4
update persons set profit = -500 where personid =5


ALTER TABLE PERSONS ADD GENDER VARCHAR
alter table persons drop column GENDER
alter table persons add gender varchar
alter table persons alter column gender varchar(100)
update persons set gender = 'male' where personid =1
update persons set gender = 'female' where personid =2
update persons set gender = 'male' where personid =3
update persons set gender = 'male' where personid =4
update persons set gender = 'female' where personid =5

select * from persons;

-- drop table persons