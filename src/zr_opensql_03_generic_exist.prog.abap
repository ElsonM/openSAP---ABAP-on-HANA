*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_03_GENERIC_EXIST
*&---------------------------------------------------------------------*
*& Open SQL Check record
*&---------------------------------------------------------------------*
REPORT zr_opensql_03_generic_exist.

"Generic check if a sales order exists
SELECT SINGLE @abap_true
  FROM snwd_so
  INTO @DATA(lv_exists)
  WHERE so_id = '0500100514'.

IF lv_exists = abap_true.
  "Do some awesome application logic
ELSE.
  "No sales order exists
ENDIF.
