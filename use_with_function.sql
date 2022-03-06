with g as (select level a from dual connect by level <=5 )  , 
h  as (select increaceseq('SQ_CLAIM_SERVICE_ITEM' , (select count(*) from g)) as b  from dual )  
select * from table (select b from h) s join g on s.id=g.a;
