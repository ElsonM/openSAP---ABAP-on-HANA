*&---------------------------------------------------------------------*
*& Report ZR_ADBC_PROC_CALL
*&---------------------------------------------------------------------*
*& ADBC - Calling an AMDP method of a class
*&---------------------------------------------------------------------*
REPORT zr_adbc_proc_call.

"Type definitions
TYPES:
  BEGIN OF ty_overview,
    value TYPE string,
    table TYPE string,
  END OF ty_overview,

  BEGIN OF ty_invoice_header,
    invoice_guid TYPE snwd_so_inv_head-node_key,
    created_at   TYPE snwd_so_inv_head-created_at,
    paid_at      TYPE snwd_so_inv_head-changed_at,
    buyer_guid   TYPE snwd_so_inv_head-buyer_guid,
  END OF ty_invoice_header.
TYPES:
  BEGIN OF ty_invoice_item,
    item_guid     TYPE snwd_so_inv_item-node_key,
    invoice_guid  TYPE snwd_so_inv_head-node_key,
    product_guid  TYPE snwd_so_inv_item-product_guid,
    gross_amount  TYPE snwd_so_inv_item-gross_amount,
    currency_code TYPE snwd_so_inv_item-currency_code,
  END OF ty_invoice_item.
TYPES:
  BEGIN OF ty_customer_info,
    customer_guid TYPE snwd_bpa-node_key,
    customer_id   TYPE snwd_bpa-bp_id,
    customer_name TYPE snwd_bpa-company_name,
    country       TYPE snwd_ad-country,
    postal_code   TYPE snwd_ad-postal_code,
    city          TYPE snwd_ad-city,
  END OF ty_customer_info.
TYPES:
  tt_invoice_header TYPE STANDARD TABLE OF ty_invoice_header WITH KEY invoice_guid.
TYPES:
  tt_invoice_item TYPE STANDARD TABLE OF ty_invoice_item.
TYPES:
  tt_customer_info TYPE STANDARD TABLE OF ty_customer_info.


DATA lv_stmt TYPE string.
DATA lo_stmt TYPE REF TO cl_sql_statement.
DATA lo_res TYPE REF TO cl_sql_result_set.
DATA lt_overview TYPE STANDARD TABLE OF ty_overview.
DATA lt_inv_head TYPE tt_invoice_header.
DATA lt_inv_item TYPE tt_invoice_item.
DATA lt_cust_info TYPE tt_customer_info.

lv_stmt = |CALL "SAPHANADB"."ZCL_DEMO_PAID_ON_DATE_AMDP=>PAID_ON_DATE" | &&
          |( '20231105', NULL, NULL, NULL ) WITH OVERVIEW|.

TRY.
    lo_stmt = NEW cl_sql_statement( ).
    lo_res  = lo_stmt->execute_query( lv_stmt ).

    "Get a reference of the overview table and prepare the result set
    lo_res->set_param_table( REF #( lt_overview ) ).

    "Retrieve the overview table
    lo_res->next_package( ).

    LOOP AT lt_overview INTO DATA(ls_overview).

      "Select from the corresponding DB table listed in the overview table
      DATA(lo_res_tab) = lo_stmt->execute_query( |SELECT * FROM { ls_overview-table }| ).

      IF ls_overview-value CS 'ET_INVOICE_ITEM'.
        "Prepare the result set
        lo_res_tab->set_param_table( REF #( lt_inv_item ) ).
      ELSEIF ls_overview-value CS 'ET_INVOICE_HEAD'.
        "Prepare the result set
        lo_res_tab->set_param_table( REF #( lt_inv_head ) ).
      ELSEIF ls_overview-value CS 'ET_CUSTOMER_INFO'.
        "Prepare the result set
        lo_res_tab->set_param_table( REF #( lt_cust_info ) ).
      ENDIF.

      "Fetch the content of the database tables into the internal tables
      lo_res_tab->next_package( ).

    ENDLOOP.
    lo_res->close( ).

  CATCH cx_sql_exception INTO DATA(lx).
    "Do some meaningful error handling
    WRITE: lx->sql_message.
ENDTRY.

cl_demo_output=>display_data( name = 'Customer Info'  value = lt_cust_info ).
