select * from table ( numlist(1,2,3)) t left join test hc 
on hc.id=t.column_value
where hc.id is null 
