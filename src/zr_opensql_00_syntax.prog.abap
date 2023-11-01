*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_00_SYNTAX
*&---------------------------------------------------------------------*
*& Open SQL Syntax
*&---------------------------------------------------------------------*
REPORT zr_opensql_00_syntax.

TYPES: BEGIN OF ty_so_amount,
         so_id         TYPE snwd_so-so_id,
         currency_code TYPE snwd_so-currency_code,
         gross_amount  TYPE snwd_so-gross_amount,
       END OF ty_so_amount.

DATA lt_so_amount TYPE STANDARD TABLE OF ty_so_amount.

"Using the "old" Open SQL syntax
SELECT so_id
       currency_code
       gross_amount
  FROM snwd_so
  INTO TABLE lt_so_amount.

"Using the "new" Open SQL syntax
SELECT so_id,
       currency_code,
       gross_amount
  FROM snwd_so
  INTO TABLE @lt_so_amount.

"Demo of the result set type inference
SELECT so_id,
       currency_code,
       gross_amount,
       delivery_status
  FROM snwd_so
  INTO TABLE @DATA(lt_result).
