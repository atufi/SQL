with bru (id,
master_id,
record_id,
table_id,
application_system_id,
application_process_id) as
 (select bru_parent.id,
         bru_parent.master_id,
         bru_parent.record_id,
         bru_parent.table_name_id,
         bru_parent.application_system_id,
         bru_parent.application_process_id
  
    from  bru_parent where bru_parent.record_id in (372) and bru_parent.table_name_id=585 --and bru_parent.application_system_id=44 --and bru_parent
  union all 
  select bru_child.id,
         bru_child.master_id,
         bru_child.record_id,
         bru_child.table_name_id,
         bru_child.application_system_id,
         bru_child.application_process_id
  
    from   bru_child , bru where bru_child.master_id=bru.id --and bru_child.master_id<> bru_child.id
    
   )
   CYCLE id SET cycle TO '1' DEFAULT '0'
select bru.*, em.*,em.rowid from bru left join cor.exception_message em on em.rule_exception_id=bru.id  where cycle=0;
