select x.id, xt.release_date_p , xt.reception_date_p ,
case 
  when xt.reception_date_p = '/////' or xt.reception_date_p = '//' or xt.reception_date_p like '///%' then to_date('1900/01/01' ,'yyyy/mm/dd')
  when  xt.reception_date_p like '%///' then  to_date(replace(xt.reception_date_p, '///', '') DEFAULT null   ON CONVERSION ERROR,
                           'yyyy/mm/dd',
                           'nls_calendar=persian'   ) 
    else                          to_date(xt.reception_date_p DEFAULT null   ON CONVERSION ERROR,
                           'yyyy/mm/dd/hh24/mi/ss',
                           'nls_calendar=persian') 
    end,
case 
  when xt.release_date_p = '/////' or xt.release_date_p = '//' or xt.release_date_p like '///%' then to_date('1900/01/01' ,'yyyy/mm/dd')
  when  xt.release_date_p like '%///' then  to_date(replace(xt.release_date_p, '///', '') DEFAULT null   ON CONVERSION ERROR,
                           'yyyy/mm/dd',
                           'nls_calendar=persian'   ) 
    else                          to_date(xt.release_date_p DEFAULT null   ON CONVERSION ERROR,
                           'yyyy/mm/dd/hh24/mi/ss',
                           'nls_calendar=persian') 
    end

FROM  x ,
           XMLTABLE(xmlnamespaces('http://thrita.behdasht.gov.ir/VM/' as "VM"),
           '/PatientBillMessageVO/VM:Composition' PASSING
            x.xml_content COLUMNS
           reception_date_p varchar(50) PATH
                    'string-join((./VM:Admission/VM:AdmissionDate/VM:Year,./VM:Admission/VM:AdmissionDate/VM:Month,
                ./VM:Admission/VM:AdmissionDate/VM:Day,./VM:Admission/VM:AdmissionTime/VM:Hour
                ,./VM:Admission/VM:AdmissionTime/VM:Minute,./VM:Admission/VM:AdmissionTime/VM:Second),"/")',
                    -------------------------------------------------------------------
                    release_date_p varchar(50) PATH
                    'string-join((./VM:Discharge/VM:DischargeDate/VM:Year,./VM:Discharge/VM:DischargeDate/VM:Month,
                ./VM:Discharge/VM:DischargeDate/VM:Day,./VM:Discharge/VM:DischargeTime/VM:Hour
                ,./VM:Discharge/VM:DischargeTime/VM:Minute,./VM:Discharge/VM:DischargeTime/VM:Second),"/")' ) xt
 where  x.id = 123 ;                
