function get_fcr_bill_claim_record(p_cursor IN t_parallel_bill_type_ref_cursor)
    RETURN fcr_bill_claim_tab_type /*bill_type_tab*/    PIPELINED  
    PARALLEL_ENABLE(PARTITION p_cursor BY any
   ) IS
   
  
   l_row      bill_type;
   l_rows_out fcr_bill_claim_tab_type;   
    
 
 BEGIN
    
   LOOP
     FETCH p_cursor
       INTO l_row.bill_id;
     EXIT WHEN p_cursor%NOTFOUND;
      
      select b.id bill_id       
 where  b.id =l_row.bill_id;
      
      --commit;
      --PIPE ROW(l_row);
     if l_rows_out.count > 0 then
       for i in l_rows_out.first .. l_rows_out.last loop
         PIPE ROW(l_rows_out(i));
       end loop;
     end if;
   END LOOP;
   RETURN;
 END get_fcr_bill_claim_record; 
