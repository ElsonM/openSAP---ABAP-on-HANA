*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_02_LITERALS
*&---------------------------------------------------------------------*
*& Open SQL Literals
*&---------------------------------------------------------------------*
REPORT zr_opensql_02_literals.

SELECT so~so_id,
       'X' AS literal_x,
       42 AS literal_42
  FROM snwd_so AS so
  INTO TABLE @DATA(lt_result).

cl_demo_output=>display_data( value = lt_result ).
