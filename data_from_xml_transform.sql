select csi.genuine_inquiry, si.code,dt.irc,c.claim_number,vhc.province_name,
       vhc.university_name,
       vhc.hcp_company_name,
       u.PrescriptionID,
       u.UID_CODE,
 c.id, csi.drug_ttac_id , smd.id , csi.id
  from  smd
  join  c
    on c.id = smd.claim_id
  join   csg
    on csg.claim_id = c.id
  join   csi
    on csi.claim_service_group_id = csg.id
  join   si
    on si.id = csi.service_item_id
  join   dt on dt.id=csi.drug_ttac_id  
  and si.code<>dt.irc 
  join vhc
    on vhc.hcp_company_id = c.hcp_company_id
  cross apply (
  
  SELECT
        x.*     
    FROM
        (SELECT
            ROWNUM            AS ID,
            xt.SDID           AS SDID,
            xt.UID_CODE,
            xt.PrescriptionID             
        FROM
            (SELECT
                XMLTRANSFORM(ss.xml_content,
                y.xslt_content) xml_content,
                sd.release_date                     
            FROM
                 ss                     
            join
                  sd                       
                    on sd.id = ss.id                     
            join
                  y                       
                    on y.id = 6                    
            WHERE
                ss.id =smd.id ) s            CROSS APPLY(XMLTABLE(xmlnamespaces('http://thrita.behdasht.gov.ir/VM/' AS VM),
            'for $i in /PatientBillMessageVO/Service_Item return $i' PASSING s.xml_content COLUMNS SDID VARCHAR(200) PATH './SDID',
            UID_CODE varchar(64) PATH './OTHERIDS/OTHERID[TYPE="UID"]/ID',
            PrescriptionID varchar(64) PATH './OTHERIDS/OTHERID[TYPE="PrescriptionID"]/ID')) xt) x
            
  
  ) u    
 where c.creation_date >= sysdate - 10
   and csi.genuine_inquiry is not null
   and csi.genuine_inquiry not like 'HCP%'
   and u.sdid=csi.sdid
