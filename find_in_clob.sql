select t.*,t.rowId from   t where
t.application_code ='TEST'  
and  dbms_lob.instr(t.compressed_stack,  utl_raw.cast_to_raw('ORA-00001: unique constraint (tt) violated')) > 0 
and trunc(t.occur_date)>=trunc(sysdate)-5
