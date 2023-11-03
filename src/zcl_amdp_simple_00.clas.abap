CLASS zcl_amdp_simple_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES:
      BEGIN OF ty_customer_info,
        customer_id        TYPE snwd_bpa-bp_id,
        customer_name      TYPE snwd_bpa-company_name,
        currency_code      TYPE snwd_so-currency_code,
        total_gross_amount TYPE snwd_so-gross_amount,
        undefined          TYPE i,
      END OF ty_customer_info,

      tt_customer_info TYPE STANDARD TABLE OF ty_customer_info.

    METHODS get_customer_infos
      EXPORTING
        VALUE(et_customer_info) TYPE tt_customer_info
      RAISING
        cx_amdp_error.

ENDCLASS.

CLASS zcl_amdp_simple_00 IMPLEMENTATION.

  METHOD get_customer_infos BY DATABASE PROCEDURE FOR HDB
    LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY
    USING snwd_bpa snwd_so.

    DECLARE lv_zero INTEGER;
    lv_zero := 0;

    et_customer_info =
      SELECT bp_id AS customer_id,
             company_name AS customer_name,
             so.currency_code,
             SUM( so.gross_amount ) AS total_gross_amount,
             ( 1 / :lv_zero ) as undefined
      FROM snwd_bpa AS bpa
      INNER JOIN snwd_so AS so
         ON bpa.node_key = so.buyer_guid
      GROUP BY bp_id, company_name, so.currency_code
      ORDER BY bp_id;

  ENDMETHOD.

ENDCLASS.

