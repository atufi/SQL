select em.message  ,count(*)  , rtrim(xmlagg(XMLELEMENT(e,bru_parent.record_id,';').EXTRACT('//text()')
                     ).GetClobVal(),',') z
    from  
      cor.business_rule_exception bru_parent
      
 where em.exception_message_type_id=227
 
group by bru_parent.system_id;
