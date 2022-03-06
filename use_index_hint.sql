select /*+ORDERED INDEX(c CLM_RELEASE_DATE_TRC_IDX   )   */
  hc.name,lt.name,sg.name,si.code,si.name,t.name--,csi.tariff ,  csi.first_insurance_amount,sum(csi.quantity)--,si.id , 
  from   c
  join   hc
    on hc.university_id = 195
   and hc.id = c.hcp_company_id
   join lp
     on c.hcp_company_id = lp.id        
   join   lt
     on lp.legal_type_id = lt.id
  join   csg
    on csg.claim_id = c.id
  join   csi
    on csi.claim_service_group_id = csg.id
  join t  sg
    on sg.id = csg.service_group_id
  join   si
    on si.id = csi.service_item_id
  join  t on t.id=si.terminology_id --and t.id=3
 where c.status_id not in (65) and c.claim_type_id not in (1)
 and c.release_date between
       to_date('1399/04/01', 'yyyy/mm/dd', 'nls_calendar=persian') and
       to_date('1399/04/05', 'yyyy/mm/dd', 'nls_calendar=persian')
   and sg.id != 97 
   and si.category_type = 'othe'
   --and csi.tariff -  csi.first_insurance_amount  > 1000
  /* and si.code='53'*/
   and not exists (select 1
          from   os 
          join   sto
            on sto.other_service_id = os.id
          where os.service_item_id = si.id  )
   and not exists (select 1 from   s where s.code=si.code and s.terminology_id=si.terminology_id
   and s.category_type !='othe' and s.disable_date is null )      
group by hc.name,si.code,si.name,t.name ,lt.name,sg.name--,csi.tariff ,  csi.first_insurance_amount
