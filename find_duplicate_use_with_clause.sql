with sd as
 (select *
    from   t
   where t.id in (select min(s2md.id)
                    from   s2md
                   where s2md.status = 'SAVED_INFO'
                     --and s2md.id = 18618801
                   group by s2md.compositionuid)
   order by t.id desc fetch first 2000 row only),
duplicate_claim_by_claim_number as
 (select sd.id,
         listagg(duplicate.id, ',' on overflow truncate) within group(order by duplicate.id) duplicated,
         'CLAIM_ID' type
    from sd
   cross apply (select c.id
                 from   c
                where c.hcp_company_id = sd.hcp_company_id
                  and c.claim_number = sd.claim_number
                  and c.status_id not in (65, 70)) duplicate
  
   group by sd.id),
duplicate_s2m_by_claim_number as
 (select sd.id,
         listagg(duplicate.id, ',' on overflow truncate) within group(order by duplicate.id) duplicated,
         'SAVE2MART_ID' type
    from sd
   cross apply (SELECT T.ID
                 FROM   T
                WHERE T.CLAIM_NUMBER = sd.CLAIM_NUMBER
                  AND T.HCP_COMPANY_ID = sd.HCP_COMPANY_ID
                  AND T.STATUS IN ('VALIDATE_PROCESSING',
                                   'VALIDATED',
                                   'SAVE_PROCESSING',
                                   'SAVED',
                                   'RE_SAVED',
                                   'SAVED_INFO')
                  AND T.ID <> sd.id) duplicate
   where sd.id not in (select dc.id from duplicate_claim_by_claim_number dc)
   group by sd.id),
duplicate_s2m_by_Compositionuid as
 (select sd.id,
         listagg(duplicate.id, ',' on overflow truncate) within group(order by duplicate.id) duplicated,
         'SAVE2MART_ID' type
    from sd
   cross apply (SELECT T.id
                 FROM   T
                WHERE T.Compositionuid = sd.Compositionuid
                  AND T.STATUS IN ('VALIDATE_PROCESSING',
                                   'VALIDATED',
                                   'SAVE_PROCESSING',
                                   'SAVED',
                                   'RE_SAVED',
                                   'SAVED_INFO')
                  AND T.ID <> sd.id) duplicate
   where sd.id not in (select dc.id from duplicate_claim_by_claim_number dc)
   group by sd.id),
duplicate_claim_by_Compositionuid as
 (select sd.id,
         listagg(duplicate.id, ',' on overflow truncate) within group(order by duplicate.id) duplicated,
         'CLAIM_ID' type
    from sd
   cross apply (select c.id
                 from   T
                 join   c
                   on c.id = t.claim_id
                WHERE T.Compositionuid = sd.Compositionuid
                  AND T.ID <> sd.id
                  and c.status_id not in (65, 70)) duplicate
   where sd.id not in (select dc.id from duplicate_s2m_by_Compositionuid dc)
     and sd.id not in (select dc.id from duplicate_s2m_by_claim_number dc)
   group by sd.id),
s2m_duplicated as
 (select *
    from duplicate_s2m_by_claim_number
  union
  select *
    from duplicate_claim_by_claim_number
  union
  select *
    from duplicate_s2m_by_Compositionuid
  union
  select *
    from duplicate_claim_by_Compositionuid)
select sd.id                     s2m_id,
       s2m_duplicated.id         s2m_duplicated_id,
       s2m_duplicated.duplicated duplicated_id,
       s2m_duplicated.type       duplicated_type
  from sd
  left join s2m_duplicated
    on sd.id = s2m_duplicated.id
