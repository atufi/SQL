select json_object('national_code'         VALUE cp.national_code,
'reception_date' value c.reception_date,
'release_date' value c.release_date,
'services ' value JSON_ARRAYAgg ( JSON_OBJECT(   KEY 'code' VALUE si.code , key 'name' value si.name , key 'category' value sc.name ) ) )
from   c
  
  join   si
    on si.id = 123  
  join   cs on cs.code=si.code
  join   scl
    on cs.service_category_location_id = scl.id
  join sc on sc.id=scl.service_category_id  
  
where  

si.category_type='rvu'

group by c.national_code, c.reception_date,c.release_date
