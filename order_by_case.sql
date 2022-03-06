order by case
                          when at.claim_type_id is null then
                           0
                          else
                           1
                        end + case
                          when at.service_category_id is null then
                           0
                          else
                           1
                        end + case
                          when at.service_group_id is null then
                           0
                          else
                           1
                        end + case
                          when at.service_type_id is null then
                           0
                          else
                           1
                        end + case
                          when at.service_item_id is null then
                           0
                          else
                           1
                        end desc,
                        at.priority fetch first 1 rows only
