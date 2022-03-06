select diag.*, surgery.*, c.id,b.id
  from   b
  join   c
    on c.bill_id = b.id
  join   ec
    on ec.id = c.id
  join  cp
    on cp.id = c.claim_policy_id
  join   clp 
    on clp.id=cp.contract_less_policy_id
 outer apply (select claim_id,
                     max(disease_type_id_1) disease_type_id_1,
                     max(disease_type_id_2) disease_type_id_2,
                     max(disease_type_id_3) disease_type_id_3
                from (select rownum rn, t.claim_id, t.disease_type_id
                        from   t
                       where t.claim_id = c.id --246126926
                         and t.diagnosis_type_id = 10
                       order by t.diagnosis_time desc fetch first 3 rows only) d
              pivot(min(d.disease_type_id)
                 for rn in(1 disease_type_id_1, 2 disease_type_id_2, 3 disease_type_id_3))
               group by claim_id) diag
 outer apply (select claim_id,
                     max(service_item_id_1) service_item_id_1,
                     max(service_item_id_2) service_item_id_2,
                     max(service_item_id_3) service_item_id_3
                from (select rownum rn, s.*
                        from (select csg.claim_id , si.id service_item_id
                                from   csg
                                join   csi
                                  on csi.claim_service_group_id = csg.id
                                 and csg.service_group_id in (100, 160)
                                join   si
                                  on si.id = csi.service_item_id
                                 and si.terminology_id = 1
                                 and si.category_type = 'rvu'
                               where csg.claim_id = c.id                            
                               order by csi.first_insurance_amount desc fetch first 3 rows only) s) d
              pivot(min(d.service_item_id)
                 for rn in(1 service_item_id_1,
                          2 service_item_id_2,
                          3 service_item_id_3))
              
               group by claim_id) surgery
 where c.id in (175346050,)
 
