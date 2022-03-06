 
select INSURED_NAME,
  case col  
    when 1 then 'FULL_TIME_K'
    when 2 then 'SCIENTIFIC_BOARD_K'
    when 3 then 'DEPRIVED_AREAS_K'
    end SERVICE_GROUP_NAME ,
 UNIVERSITY_NAME ,
              COMPANY_NAME,
              RELEASE_DATE,
              CLAIM_TYPE_NAME,
              SERVICE_TYPE_NAME,              
              col ,
              LEGAL_TYPE_code           as LEGAL_TYPE_code,
              0 as first_FULL_TIME_K,
              0 as second_FULL_TIME_K,
              0 as priority,
              claim_id,
              sum(c1)             as first_first_k,
              sum(c2)             as second_first_k,
              0  as first_SCIENTIFIC_BOARD_K,
              0 as second_scientific_board_k,
              0    as first_deprived_areas_k,
              0   as second_deprived_areas_k,
              ''         as INSURER_CASH_NAME
                
  from  VW_NEW t1 
  --UNPIVOT( c1 for col in  (first_FULL_TIME_K,second_FULL_TIME_K,first_scientific_board_k,second_scientific_board_k,first_deprived_areas_k,second_deprived_areas_k)) 
  UNPIVOT((c1, c2) for col in((first_FULL_TIME_K,
                                                                                   second_FULL_TIME_K) as 1 , 
                                                                                  (first_scientific_board_k,
                                                                                   second_scientific_board_k) as 2 ,
                                                                                  (first_deprived_areas_k,
                                                                                   second_deprived_areas_k) as 3  
                                                                                   ))
 where id in ( 106786800)
 group by claim_id, col,INSURED_NAME ,UNIVERSITY_NAME ,COMPANY_NAME ,RELEASE_DATE,CLAIM_TYPE_NAME ,SERVICE_TYPE_NAME,LEGAL_TYPE_code
 order by 1,2
