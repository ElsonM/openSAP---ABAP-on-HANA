*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_04_ARITH_EXPRESS
*&---------------------------------------------------------------------*
*& Open SQL Arithmetic Expressions
*&---------------------------------------------------------------------*
REPORT zr_opensql_04_arith_express.

DATA lv_discount TYPE p LENGTH 1 DECIMALS 1 VALUE '0.8'.

SELECT ( 1 + 1 ) AS two,
       ( @lv_discount * gross_amount ) AS red_gross_amount,
       CEIL( gross_amount )            AS ceiled_gross_amount
  FROM snwd_so
  INTO TABLE @DATA(lt_result).

cl_demo_output=>display_data( value = lt_result ).
