declare 
TYPE NumList IS TABLE OF NUMBER;
sqids NumList;
t number ;
res SYS_REFCURSOR ;
--cursor xt is  select  sq_test.nextval    from dual  connect by level <= 5;
begin
--select level into t from  dual where rownum=1 connect by level <=5;
open res for select  sq_test.nextval    from dual  connect by level <= 5;
FETCH res BULK COLLECT INTO sqids;
/*for i in 1..1
  loop  
    fetch res into t ;
    dbms_output.put_line (t) ;
end loop; */
--select   sqids(1) into t  from dual ;    
t:=sqids(1) ;
--select sq_test.curvar into t from dual ;
dbms_output.put_line (t) ;
end;
