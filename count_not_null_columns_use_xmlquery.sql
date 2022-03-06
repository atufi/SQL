select   
 xmlquery( 'for $i in /SIP return $i/count(*)'     passing xmlelement( "SIP", xmlforest(  sip.claim_type_id, sip.service_group_id, sip.service_type_id )  )RETURNING CONTENT ).EXTRACT('//text()').getStringVal()
 /*case when sip.claim_type_id is null then 0 else 1 end+case when sip.service_group_id is null then 0 else 1 end
   +case when sip.service_type_id is null then 0 else 1 end*/
from    sip
where sip.service_item_id = 8561 
