select t.description, REGEXP_SUBSTR (t.description,'(nomeidcalSystem)\":\"(.+)(\"})',1, 1, 'i',2),
case when regexp_like(REGEXP_SUBSTR (t.description,'(nomeidcalSystem)\":\"(.+)(\"})',1, 1, 'i',2), '^\d+(\.\d+)?$') 
            then 'numeric'
            else 'alfa'
      end
  from   sd join 
   t on t.save2mart_id=sd.id
  
 where sd.status = 'RE_VALIDATED_FAILED' and 
  
 t.description like  '%Error=The remote server returned an error: (400) Bad Request%'
       
