select distinct table_name_id,record_id,sdid
    bulk collect into gv_all_sid_list
  from (select csg.id as claim_service_group_id,
               csi.id as claim_service_item_id,
               crs.id as claim_related_service_id,
               sg.ehr_code as claim_service_group_sdid,
               csi.sdid as claim_service_item_sdid,
               crs.sdid as claim_related_service_sdid,
               c.id as claim_id,
               to_char(c.id) as claim_sdid
          from    c
          left  csg
            on csg.claim_id = c.id
          left sg
            on sg.id = csg.service_group_id
          left   csi
            on csi.claim_service_group_id = csg.id
          left  crs
            on crs.claim_service_item_id = csi.id
         where c.id = gv_claim_id) unpivot((record_id, sdid) for table_name_id in((claim_id,
                                                                                 claim_sdid) as 110,
                                                                                (claim_service_group_id,
                                                                                 claim_service_group_sdid) as 130,
                                                                                (claim_service_item_id,
                                                                                 claim_service_item_sdid) as 131,
                                                                                (claim_related_service_id,
                                                                                 claim_related_service_sdid) as 590))
