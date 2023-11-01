*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_01_AGGREGATION
*&---------------------------------------------------------------------*
*& Open SQL Aggregation
*&---------------------------------------------------------------------*
REPORT zr_opensql_01_aggregation.

SELECT bp_id,
       company_name,
       so~currency_code,
       SUM( so~gross_amount ) AS total_gross_amount
  FROM snwd_so AS so
  INNER JOIN snwd_bpa AS bpa
          ON so~buyer_guid = bpa~node_key
  INTO TABLE @DATA(lt_result)
  GROUP BY bp_id, company_name, so~currency_code.

cl_demo_output=>display_data( value = lt_result ).
