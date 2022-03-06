select a.OBJECT_NAME,count(b.name) 
from ALL_OBJECTS   a  , all_dependencies  b
where   a.owner='TEST' and
a.OBJECT_NAME = b.NAME  
and b.REFERENCED_TYPE  in('PROCEDURE','FUNCTION')
and a.OBJECT_TYPE in('PROCEDURE','FUNCTION')
--
group by OBJECT_NAME
order by 2
