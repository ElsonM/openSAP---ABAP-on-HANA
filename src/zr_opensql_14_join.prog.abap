*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_14_JOIN
*&---------------------------------------------------------------------*
*& Open SQL Join
*&---------------------------------------------------------------------*
REPORT zr_opensql_14_join.

SELECT
  so_id,
  bp_id,
  gross_amount
  FROM snwd_so AS so
  RIGHT OUTER JOIN snwd_bpa AS bpa
    ON so~buyer_guid = bpa~node_key
    AND so~gross_amount > 100000
  INTO TABLE @DATA(lt_result).

cl_demo_output=>display_data( value = lt_result ).
