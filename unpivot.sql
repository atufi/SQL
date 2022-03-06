select rownum id,
       gs.id global_service_id,
       tarif_detail.service_group_id,
       null  version_cause,
       0 service_version,
       nvl(tarif_detail.tarrif,0) price,
       to_date('20 march 2020') effective_date,
       null disable_date,
       30 creator_id,
       30 last_modifier_id,
       sysdate creation_date,
       sysdate last_modification_date,
       0 version,
       gstn.id global_service_tariff_id 
       --gs.id, count(*) 
        from 
(select * from  global_service_temp_99 t 

unpivot INCLUDE NULLS  ( tarrif for service_group_id in (HAGH_BIHOOSHI as 121,
HAZINEH_SONOGRAPHY as 108,
HAZINEH_RADIOLOGY as 111,
HAZINEH_ELECTROKARDIOGRAFI as 113,
HAZINEH_DAROO as 103,
HAZINEH_MOSHAVEREH as 98,
HAGH_KOMAK_JARRAH as 101,
HAZINEH_OTAAGH_AMAL as 122,
HAZINEH_VASAAEL_MASRAFI as 104,
--HOTTELING_PLUS_PARASTARI as 126,
HAZINEH_AZMAYESH as 115,
SAYER_HAZINEHA as 139,
HAGH_JARRAHI as 100,
HAZINEH_VIZIT as 119,
HAZINEH_PATOLOGY as 116) )
/*where melli_code='990256'*/) tarif_detail
join  gs on gs.national_code=tarif_detail.melli_code and gs.disable_date is null 
join   gstn on gstn.global_service_id=gs.id --and gstn.accreditation_level_id=1
--group by gs.id
 
