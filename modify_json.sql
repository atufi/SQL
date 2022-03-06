declare 
po_obj  JSON_OBJECT_T;
json_context clob;
cursor error_bill is  select t._id,
       
       t.json_context ,
       
       bl.id bill_Letter_Id
  from t.task_instance t
   
 outer apply (select *
                from json_table(ci.json_context,
                                '$' columns(billLetterId varchar(50) PATH
                                        '$.billLetterId'))) resultJson
where t.task_id in (
1
)
and TRUNC(t.LAST_MODIFICATION_DATE) >='20 sep 2020'
and resultJson.billLetterId is null;
begin
  --select  ci.json_context into json_context from wfm.context_instance ci where ci.step_instance_id=1034162107;
  for cr in error_bill loop
      json_context:= cr.json_context;
      dbms_output.put_line (   json_context);
      
      po_obj := JSON_OBJECT_T.parse(json_context);
      po_obj.put('billLetterId', cr.bill_Letter_Id);

      dbms_output.put_line (   po_obj.to_clob);
  end loop;
end;  
 
