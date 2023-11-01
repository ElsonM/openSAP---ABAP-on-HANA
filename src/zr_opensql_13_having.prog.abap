*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_13_HAVING
*&---------------------------------------------------------------------*
*& Open SQL Having
*&---------------------------------------------------------------------*
REPORT zr_opensql_13_having.

SELECT bp_id,
       company_name,
       so~currency_code,
       SUM( so~gross_amount ) AS total_amount
  FROM snwd_so AS so
  INNER JOIN snwd_bpa AS bpa
  ON bpa~node_key = so~buyer_guid
  INTO TABLE @DATA(lt_result)
  WHERE so~delivery_status = ' '
  GROUP BY
    bp_id,
    company_name,
    so~currency_code
  HAVING SUM( so~gross_amount ) > 10000000.

cl_demo_output=>display_data( value = lt_result ).
