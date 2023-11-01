@AbapCatalog.sqlViewName: 'ZDDLS_CDS_32A'
define view zcdsv_filter_example_base as
  select from snwd_so_inv_head as invoice_header
  association[1..*] to snwd_so_inv_item as invoice_items
   on $projection.header_guid = invoice_items.parent_key
 { 
   invoice_header.so_guid  as order_guid,
   invoice_header.node_key as header_guid,
   invoice_items
 }
