with 
estelam_hcp as (select   smd.irc,  smd.amount   sum_amount 

    from   smd
  
                           
   where smd.id = 100134591
  ) , 
csi_all as
 (select si.code servie_item_code, csi.quantity,
 csi.id ,
 sum(csi.quantity) over( partition by eh.irc order by csi.id ) as quantity_sumover,
 sum_amount
  
    from sepas.save2mart_detail smd
  
    join   c
      on c.id = smd.claim_id
    join  csg
      on csg.claim_id = c.id
    join  csi
      on csi.claim_service_group_id = csg.id
    join   si
      on si.id = csi.service_item_id
    join estelam_hcp eh on  eh.irc= si.code 
   where smd.id = 100134591      
     and csi.genuine_inquiry is null
   )
select f.*,
       (case
         when sum_amount >= quantity_sumover - quantity then
          least(sum_amount - (quantity_sumover - quantity), quantity)       
         else
          0
       end) as confirmed_quantity 
 
from csi_all f 
