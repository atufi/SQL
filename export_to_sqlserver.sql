
SELECT * into  kosor_1 FROM OPENQUERY( [test]   , 'SELECT to_char(b.FROM_DATE, ''yyyy/mm'', ''nls_calendar=persian'') bill_month , csi.id                   as s_id,
       c.claim_number,
        
  from  
     c
    
 where 1=2  
    
   ') ;
