@AbapCatalog.sqlViewName: 'ZDDLS_CDS_32B'
define view zcdsv_filter_example_vov as
  select from snwd_so as so
  association [1] to snwd_bpa as business_partners
    on so.buyer_guid = business_partners.node_key
  association [0..1] to zcdsv_filter_example_base as invoice_headers
    on so.node_key = invoice_headers.order_guid { 
    
  key so.so_id as order_id,   
      -- Value 01 means customer
      business_partners[ bp_role = '01' ].company_name as customer_name,
    
      -- Filter 1..n association on first position
      invoice_headers.invoice_items[1: inv_item_pos = '0000000010'].currency_code,
      invoice_headers.invoice_items[1: inv_item_pos = '0000000010'].gross_amount
 }
 where invoice_headers.header_guid is not null
