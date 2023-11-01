@AbapCatalog.sqlViewName: 'ZVOIA_ALV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View for Basic ALV'
define view zcdsv_oia_basic_alv 
  as select from snwd_so as so
  inner join snwd_bpa as bp on so.buyer_guid = bp.node_key
  left outer join snwd_so_inv_head as so_inv on so.node_key = so_inv.so_guid {
    key so.so_id,
        so.currency_code,
        so.gross_amount,
        so.created_at,    
        bp.company_name,
        @EndUserText.label: 'Delivery status'
        case so.delivery_status 
          when ' ' then 'Open'
          when 'D' then 'Delivered'
          else so.delivery_status 
        end as delivery_status,
        @EndUserText.label: 'Short name'
        substring( bp.company_name,  1, 10 ) as short_name
}
