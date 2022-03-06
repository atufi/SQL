SELECT xt.*  
    FROM SEPAS.SAVE2MART X ,
    XMLTABLE                  (xmlnamespaces('http://thrita.behdasht.gov.ir/VM/'                   as "VM"),
           'for $i in /PatientBillMessageVO/VM:Composition/VM:BillServices/VM:ServiceDetailsVO/VM:RelatedService/VM:ServiceDetailsVO 
           where count($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="3"])<=1 
                 and count($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="2"])<=1 
                 and count($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="13"])<=1 
                 and count($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="4"])<=1 
                 and count($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="3333333"])<=1                 
                 and ( not($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="3333333"]/../VM:Value/VM:Magnitude castable as xs:decimal or string(number($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="3333333"]/../VM:Value/VM:Magnitude))="NaN" )
                 or not($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="3"]/../VM:Value/VM:Magnitude castable as xs:decimal or string(number($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="3"]/../VM:Value/VM:Magnitude))="NaN" )
                 or not($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="2"]/../VM:Value/VM:Magnitude castable as xs:decimal or string(number($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="2"]/../VM:Value/VM:Magnitude))="NaN" )
                 or not($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="13"]/../VM:Value/VM:Magnitude castable as xs:decimal or string(number($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="13"]/../VM:Value/VM:Magnitude))="NaN" )
                 or not($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="4"]/../VM:Value/VM:Magnitude castable as xs:decimal or string(number($i/VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="4"]/../VM:Value/VM:Magnitude))="NaN" )
                 
                 or not($i/VM:TotalCharge/VM:Magnitude castable as xs:decimal or string(number($i/VM:TotalCharge/VM:Magnitude))="NaN" )
                 or not($i/VM:PatientContribution/VM:Magnitude castable as xs:decimal or string(number($i/VM:PatientContribution/VM:Magnitude))="NaN" )
                 
                 or not($i/VM:BasicInsuranceContribution/VM:Magnitude castable as xs:decimal or string(number($i/VM:BasicInsuranceContribution/VM:Magnitude))="NaN" )
                 )
                 
           return $i'
                    PASSING x.xml_content COLUMNS
                    
                    PKID varchar(100) PATH  './VM:PKID' ,
                    FULL_TIME_K varchar(12) PATH
                    './VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="3333333"]/../VM:Value/VM:Magnitude',
                    DEPRIVED_AREAS_K varchar(12) PATH
                    './VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="3"]/../VM:Value/VM:Magnitude',
                    SCIENTIFIC_BOARD_K varchar(12) PATH
                    './VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="2"]/../VM:Value/VM:Magnitude',
                    FIRST_INSURANCE_AMOUNT varchar(12) PATH
                    './VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="13"]/../VM:Value/VM:Magnitude',
                    GOVERNMENT_SUBSIDIES varchar(12) PATH
                    './VM:OtherCosts/VM:QuantitiesVO/VM:Name[@Coded_string="4"]/../VM:Value/VM:Magnitude',
                    QUANTITY varchar(10) PATH './VM:ServiceCount/VM:Magnitude',
                    -------------------------------------------------
                    Total_Amount varchar(15) PATH './VM:TotalCharge/VM:Magnitude',                    
                    INSURED_PAY_AMOUNT varchar(15) PATH
                    './VM:PatientContribution/VM:Magnitude',
                    first_cover_amount varchar(15) PATH
                    './VM:BasicInsuranceContribution/VM:Magnitude',
                    
                                        HIS_PKID varchar(100) path './VM:PKID',
                                        HCP_PERSON xmltype path './VM:ServiceProvider'/**/) xt 
    where x.id= 36571841 --36615697 --37993586 
   
