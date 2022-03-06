with all_crs as
 (select crs.id                 claim_related_service_id,
         crs.hcp_person_type_id,
         crs.hcp_person_id,
         crs.k_value,
         csi.id                 claim_service_item_id,
         crs.adjustment_id,
         row_number() over(partition by crs.claim_service_item_id, crs.hcp_person_type_id, crs.hcp_person_id, crs.k_value order by crs.claim_service_item_id, crs.hcp_person_type_id, crs.hcp_person_id, crs.k_value) parent_row_id,
         row_number() over(partition by crs.claim_service_item_id, crs.adjustment_id, crs.hcp_person_type_id, crs.hcp_person_id, crs.k_value order by crs.claim_service_item_id, crs.adjustment_id, crs.hcp_person_type_id, crs.hcp_person_id, crs.k_value) child_row_id,
         hc.exclusion_factor /100  exclusion_factor
    from 
         csi
      
  
    join   crs
      on crs.claim_service_item_id = csi.id
    
   
   where    csi.id = 9717685926 and a.id not in (45)  )

    
select child_crs.claim_related_service_id  child_claim_related_service_id,
       parent_crs.claim_related_service_id parent_claim_related_service_id
  from all_crs child_crs
  join all_crs parent_crs
    on child_crs.claim_service_item_id = parent_crs.claim_service_item_id
   and child_crs.hcp_person_type_id = parent_crs.hcp_person_type_id
   and child_crs.hcp_person_id = parent_crs.hcp_person_id
   and ( 
       (child_crs.k_value = parent_crs.k_value and child_crs.adjustment_id in (55, 60) )
       or 
       (child_crs.k_value = parent_crs.k_value  *nvl(child_crs.exclusion_factor,0 )  and child_crs.adjustment_id in (25) )
   )
   and child_crs.child_row_id = parent_crs.parent_row_id
   and parent_crs.adjustment_id  not in (55, 60, 25 )
   and child_crs.adjustment_id in (55, 60, 25)
