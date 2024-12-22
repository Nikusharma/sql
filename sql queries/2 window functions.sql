select * from persons;

-- rank of current row within its partition with gaps
select *, rank() over (order by rank_no desc) as rank_output from persons;

-- rank of current row within its partition without gaps
select *, dense_rank() over(order by rank_no desc) as dense_rank_output from persons;

-- PERCENT RANK always lies between 0 & 1
-- ROW NUMBER - We have multiple rows with same rank_no provided in both rank & dense_rank, now if we don’t want to give same rank to multiple rows then row_number is used.
select *, 
rank() over(order by rank_no desc) as rank_output,
dense_rank() over(order by rank_no desc) as dense_rank_output,
percent_rank() over(order by rank_no desc) as percent_rank_output,
row_number() over(order by rank_no desc) as row_number_output
from persons;

-- NAMED WINDOW FUNCTION
select *,
rank() over w as rank_output,
dense_rank() over w as dense_rank_output,
percent_rank() over w as percent_rank_output,
row_number() over w as row_number_output
from persons
window w as (order by rank_no desc);

-- LEAD & LAG - used to get preceding & succeding value of any row within its partition
select *, lead(profit,1,0) over(order by personid) as next_profit,
lag(profit,1,0) over(order by personid) as previous_profit 
from persons;