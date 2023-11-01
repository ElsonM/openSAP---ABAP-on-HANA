@AbapCatalog.sqlViewName: 'ZDDLS_CDS_31A'
define view zcdsv_assoc_types as
  select from snwd_so as so
  association [1] to snwd_bpa as business_partners
           on $projection.buyer_guid = business_partners.node_key 
  association [0..1] to snwd_so_inv_head as invoice_headers
           on so.node_key = invoice_headers.so_guid { 
  
  key so.so_id as order_id,
      so.delivery_status,
      
      -- Ad-hoc association
      invoice_headers.payment_status,
    
      -- Field used in the ON condition
      so.buyer_guid,  
    
      -- Exposing association business_partners
      business_partners
      
 }
