*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_11_COALESCE
*&---------------------------------------------------------------------*
*& Open SQl Coalesce function
*&---------------------------------------------------------------------*
REPORT zr_opensql_11_coalesce.

SELECT so_id,
       so~gross_amount AS so_amount,
       inv_head~gross_amount AS inv_amount,
       "Potential invoice amount
       COALESCE( inv_head~gross_amount, so~gross_amount )
         AS expected_amount
  FROM snwd_so AS so
  LEFT OUTER JOIN snwd_so_inv_head AS inv_head
  ON inv_head~so_guid = so~node_key
  INTO TABLE @DATA(lt_result).

cl_demo_output=>display_data( value = lt_result ).
