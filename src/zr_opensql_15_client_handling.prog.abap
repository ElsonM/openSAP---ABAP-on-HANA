*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_15_CLIENT_HANDLING
*&---------------------------------------------------------------------*
*& Open SQL Client Handling
*&---------------------------------------------------------------------*
REPORT zr_opensql_15_client_handling.

SELECT
  bp_id,
  company_name,
  so~currency_code,
  so~gross_amount
  FROM snwd_so AS so
  INNER JOIN snwd_bpa AS bpa
    ON so~buyer_guid = bpa~node_key
    "Client 111 does not exist in the system
    USING CLIENT '111'
  INTO TABLE @DATA(lt_result).

cl_demo_output=>display_data( value = lt_result ).
