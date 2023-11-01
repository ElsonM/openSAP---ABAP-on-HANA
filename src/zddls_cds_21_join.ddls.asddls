@AbapCatalog.sqlViewName: 'ZDDLS_CDS_21'
define view zcdsv_join as
  select from snwd_so as so
  inner join snwd_bpa as bpa 
    on so.buyer_guid = bpa.node_key
  left outer join snwd_so_inv_head as inv_head 
    on so.node_key = inv_head.so_guid { 
  
  key so.so_id,
      bpa.company_name,
      so.delivery_status,
      inv_head.payment_status
      
 }
