###CHALLENGE 1
#step1
select ta.title_id as TitleID, ta.au_id as AuthorID,   (t.advance*ta.royaltyper/100  ) as 'Advance', (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'Sales_Royalties'
from titleauthor ta 
left join titles t on t.title_id = ta.title_id
left join sales s on s.title_id =ta.title_id;

#step2
select step1.TitleID, step1.AuthorID,  Advance, sum(Sales_Royalties) Total_Royalties
from (select ta.title_id as TitleID, ta.au_id as AuthorID,   (t.advance*ta.royaltyper/100  ) as 'Advance', (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'Sales_Royalties'
		from titleauthor ta 
		left join titles t on t.title_id = ta.title_id
		left join sales s on s.title_id =ta.title_id) step1
group by step1.TitleID, step1.AuthorID,  Advance;
;

#step3
select AuthorID, sum(Advance+Total_Royalties)
from (select step1.TitleID, step1.AuthorID,  Advance, sum(Sales_Royalties) Total_Royalties
from (select ta.title_id as TitleID, ta.au_id as AuthorID,   (t.advance*ta.royaltyper/100  ) as 'Advance', (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'Sales_Royalties'
		from titleauthor ta 
		left join titles t on t.title_id = ta.title_id
		left join sales s on s.title_id =ta.title_id) step1
group by step1.TitleID, step1.AuthorID,  Advance) step2
group by step2.AuthorID
order by 2 desc
limit 3;

###CHALLENGE 2

create temporary table if not exists step1
(select ta.title_id as TitleID, ta.au_id as AuthorID,   (t.advance*ta.royaltyper/100  ) as 'Advance', (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'Sales_Royalties'
from titleauthor ta 
left join titles t on t.title_id = ta.title_id
left join sales s on s.title_id =ta.title_id);

create temporary table if not exists step2 
(select step1.TitleID, step1.AuthorID,  Advance, sum(Sales_Royalties) Total_Royalties
from  step1
group by step1.TitleID, step1.AuthorID,  Advance)
;

select  AuthorID, sum(Advance+Total_Royalties) 
from  step2
group by AuthorID
order by 2 desc
limit 3;

###Challenge 3
create table Challenge3
as (select  AuthorID, sum(Advance+Total_Royalties) as Total
from  step2
group by AuthorID);


