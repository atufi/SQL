SELECT JSON_OBJECT (
         KEY 'patients' VALUE (
           SELECT JSON_ARRAYAGG(
                    JSON_OBJECT (
                      KEY 'national_code' VALUE c.national_code,
                      KEY 'reception_date' VALUE c.reception_date,
                      KEY 'release_date' VALUE c.release_date,                     
                      KEY 'services' VALUE (
                        SELECT JSON_ARRAYAGG (
                                 JSON_OBJECT(
                                   KEY 'code' VALUE si.code--,
                                   
                                    
                                 )
                               )
                        FROM   
                              si
                             
                            join   cs on cs.code=si.code
                          join   scl
                            on cs.service_category_location_id = scl.id
                          join   sc on sc.id=scl.service_category_id    
                        WHERE   csg.claim_id = c.id
                      )
                    )
                  )
           from   c
           join   cp on cp.id=c.claim_policy_id  
           and c.status_id not in (65)
         )
       ) AS patients
FROM   dual;
