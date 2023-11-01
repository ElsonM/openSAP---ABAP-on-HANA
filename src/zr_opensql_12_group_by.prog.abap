*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_12_GROUP_BY
*&---------------------------------------------------------------------*
*& Open SQL Group By
*&---------------------------------------------------------------------*
REPORT zr_opensql_12_group_by.

SELECT bp_id,
       company_name,
       so~currency_code,
       SUM( so~gross_amount ) AS total_amount,
       CASE
         WHEN so~gross_amount < 1000
           THEN 'X'
         ELSE ' '
       END AS low_volume_flag,
       COUNT( * ) AS cnt_orders
  FROM snwd_so AS so
  INNER JOIN snwd_bpa AS bpa
  ON bpa~node_key = so~buyer_guid
  INTO TABLE @DATA(lt_result)
  GROUP BY
    bp_id, company_name,
    so~currency_code,
    CASE
      WHEN so~gross_amount < 1000
        THEN 'X'
        ELSE ' '
    END
  ORDER BY company_name.

cl_demo_output=>display_data( value = lt_result ).
