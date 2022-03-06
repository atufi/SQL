 select sd.claim_number,his_pkid,service_pkid,related_service_type_code,service_service_type_code,  xt.*
 FROM  s,
        sd,
       XMLTABLE(xmlnamespaces('http://thrita.behdasht.gov.ir/VM/' as "VM"),
        'for $i in /PatientBillMessageVO/VM:Composition/VM:BillServices/VM:ServiceDetailsVO/VM:RelatedService/VM:ServiceDetailsVO
        return <My><index>{count($i/preceding-sibling::*)+1}</index>
                   <index2>{count($i/../../preceding-sibling::*)+1}</index2>
                   <related_service_type>{$i/VM:ServiceType}</related_service_type>
                   <service_service_type>{$i/../../VM:ServiceType}</service_service_type>
                   <service_pkid>{$i/../../VM:PKID}</service_pkid>
                {$i} </My>
        '
                 PASSING
                 s.xml_content
                COLUMNS
                 row_index number path 'index'  , 
                 row_index2 number path 'index2',
                -------------------------------------------------------
                -------------------------------------------------
                  
                    -------------------------------------------------------
                                                    adjust_name varchar(200) PATH 'VM:ServiceDetailsVO/VM:Service/@Value',
                                adjust_code varchar(200) PATH 'VM:ServiceDetailsVO/VM:Service/@Coded_string',
                                                role_name varchar(100) PATH 'VM:ServiceDetailsVO/VM:ServiceProvider/VM:Role/@Value',
                                role_code varchar(15) PATH 'VM:ServiceDetailsVO/VM:ServiceProvider/VM:Role/@Coded_string',
                    -------------------------------------------------
                    START_DATE_P varchar(50) PATH
                    'string-join((VM:ServiceDetailsVO/VM:StartDate/VM:Year,VM:ServiceDetailsVO/VM:StartDate/VM:Month,
                VM:ServiceDetailsVO/VM:StartDate/VM:Day,VM:ServiceDetailsVO/VM:StartTime/VM:Hour
                ,VM:ServiceDetailsVO/VM:StartTime/VM:Minute,VM:ServiceDetailsVO/VM:StartTime/VM:Second),"/")',
                    END_DATE_P varchar(50) PATH
                    'string-join((VM:ServiceDetailsVO/VM:EndDate/VM:Year,VM:ServiceDetailsVO/VM:EndDate/VM:Month,
                VM:ServiceDetailsVO/VM:EndDate/VM:Day,VM:ServiceDetailsVO/VM:EndTime/VM:Hour
                ,VM:ServiceDetailsVO/VM:EndTime/VM:Minute,VM:ServiceDetailsVO/VM:EndTime/VM:Second),"/")',
                    FULL_TIME_K number(12) PATH
                    'VM:ServiceDetailsVO/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="3333333"]/../VM:Value/VM:Magnitude',
                    DEPRIVED_AREAS_K number(12) PATH
                    'VM:ServiceDetailsVO/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="3"]/../VM:Value/VM:Magnitude',
                    SCIENTIFIC_BOARD_K number(12) PATH
                    'VM:ServiceDetailsVO/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="2"]/../VM:Value/VM:Magnitude',
                    FIRST_INSURANCE_AMOUNT number(12) PATH
                    'VM:ServiceDetailsVO/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="13"]/../VM:Value/VM:Magnitude',
                    GOVERNMENT_SUBSIDIES number(12) PATH
                    'VM:ServiceDetailsVO/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="4"]/../VM:Value/VM:Magnitude',
                    QUANTITY number(8,2) PATH 'VM:ServiceDetailsVO/VM:ServiceCount/VM:Magnitude',
                    -------------------------------------------------
                    Total_Amount number(15) PATH 'VM:ServiceDetailsVO/VM:TotalCharge/VM:Magnitude',
                    INSURED_PAY_AMOUNT number(15) PATH
                    'VM:ServiceDetailsVO/VM:PatientContribution/VM:Magnitude',
                    first_cover_amount number(15) PATH
                    'VM:ServiceDetailsVO/VM:BasicInsuranceContribution/VM:Magnitude',
                    
                    k_value number(6,2) PATH
                    'sum(/VM:RelativeCost/VM:RelativeCostVO/VM:KValue)',
                    
                                        HIS_PKID varchar(100) path 'VM:ServiceDetailsVO/VM:PKID',
                                        HCP_PERSON xmltype path 'VM:ServiceDetailsVO/VM:ServiceProvider'  ,
                                        related_service_type_code varchar(50) path 'related_service_type/VM:ServiceType/@Coded_string' ,
                                        service_service_type_code varchar(50) path 'service_service_type/VM:ServiceType/@Coded_string'
                                        , service_pkid varchar(100) path 'service_pkid '
                                        ) xt
                
               
 
 
     
 where s.id = sd.id
   and s.id = 38641321
  and related_service_type_code <> service_service_type_code 
