*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_05_CONCAT
*&---------------------------------------------------------------------*
*& Open SQL Concatenate
*&---------------------------------------------------------------------*
REPORT zr_opensql_05_concat.

SELECT company_name
    && ' (' && legal_form && ')'
  FROM snwd_bpa
  INTO TABLE @DATA(lt_result).

cl_demo_output=>display_data( value = lt_result ).
