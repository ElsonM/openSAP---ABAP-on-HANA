CLASS zcl_demo_paid_on_date_amdp DEFINITION
  PUBLIC
  INHERITING FROM zcl_demo_paid_on_date
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    METHODS paid_on_date REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_demo_paid_on_date_amdp IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DEMO_PAID_ON_DATE_AMDP->PAID_ON_DATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_PAYMENT_DATE                TYPE        D
* | [<---] ET_INVOICE_HEADER              TYPE        TT_INVOICE_HEADER
* | [<---] ET_INVOICE_ITEM                TYPE        TT_INVOICE_ITEM
* | [<---] ET_CUSTOMER_INFO               TYPE        TT_CUSTOMER_INFO
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD paid_on_date BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY
    USING snwd_so_inv_head snwd_so_inv_item snwd_bpa snwd_ad.
    -- SQL Script:
    -- VALUE(et_invoice_header) TYPE tt_invoice_header
    -- VALUE(et_invoice_item)   TYPE tt_invoice_item
    -- VALUE(et_customer_info)  TYPE tt_customer_info

    -- Get header data
    et_invoice_header = SELECT
      node_key   AS invoice_guid,
      created_at AS created_at,
      changed_at AS paid_at,
      buyer_guid
    FROM
      snwd_so_inv_head
    WHERE
      payment_status = 'P'
      AND LEFT(changed_at, 8) = :iv_payment_date;

    -- Get invoice items
    et_invoice_item =
      SELECT
        node_key   AS item_guid,
        parent_key AS invoice_guid,
        product_guid,
        gross_amount,
        currency_code
      FROM snwd_so_inv_item
      WHERE parent_key IN ( SELECT invoice_guid FROM :et_invoice_header );

     -- Get information about the customers
     et_customer_info =  SELECT DISTINCT
       bpa.node_key     AS customer_guid,
       bpa.bp_id        AS customer_id,
       bpa.company_name AS customer_name,
       ad.country,
       ad.postal_code,
       ad.city
     FROM snwd_bpa AS bpa
     JOIN snwd_ad AS ad ON ad.node_key = bpa.address_guid
     WHERE bpa.node_key IN ( SELECT buyer_guid FROM :et_invoice_header )
     ORDER BY company_name;

  ENDMETHOD.
ENDCLASS.
