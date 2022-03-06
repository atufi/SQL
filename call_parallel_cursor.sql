declare i numlist;
begin
SELECT bill_id bulk collect into i 
FROM   TABLE(pkg_test_parallel.test_ptf(CURSOR(SELECT /*+ parallel(10) */ t1.id
                                              FROM    t1 
                                             )
                                       )
            ) t2 ;
end;            
