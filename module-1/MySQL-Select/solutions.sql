select a.au_id 'AUTHOR' , a.au_lname 'LAST_NAME' , a.au_fname 'FIRST_NAME' , t.title 'TITLE', p.pub_name 'PUBLISHER'
from authors a
inner join titleauthor ta on ta.au_id=a.au_id
inner join titles t on t.title_id = ta.title_id
inner join publishers p on p.pub_id =t.pub_id ;

select a.au_id 'AUTHOR' , a.au_lname 'LAST_NAME', a.au_fname 'FIRST_NAME',  p.pub_name 'PUBLISHER', count(t.title_id) 'TITLE_COUNT'
from authors a
inner join titleauthor ta on ta.au_id=a.au_id
inner join titles t on t.title_id = ta.title_id 
inner join publishers p on p.pub_id =t.pub_id
group by  a.au_id , a.au_lname , a.au_fname ,  p.pub_name ;

select a.au_id 'AUTHOR_ID', a.au_lname 'LAST_NAME', a.au_fname 'FIRST_NAME', sum(s.qty) 'TOTAL'
from authors a
left join titleauthor ta on a.au_id = ta.au_id
left join sales s on s.title_id = ta.title_id
group by a.au_id, a.au_lname,a.au_fname 
order by 4 desc
limit  3;

select a.au_id 'AUTHOR_ID', a.au_lname 'LAST_NAME', a.au_fname 'FIRST_NAME', COALESCE(sum(s.qty), 0) 'TOTAL'
from authors a
left join titleauthor ta on a.au_id = ta.au_id
left join sales s on s.title_id = ta.title_id
group by a.au_id, a.au_lname,a.au_fname 
order by 4 desc
;

