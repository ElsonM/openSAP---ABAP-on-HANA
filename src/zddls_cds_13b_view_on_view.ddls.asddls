@AbapCatalog.sqlViewName: 'ZDDLS_CDS_13B'
define view zcdsv_view_on_view as select
from zcdsv_base 
inner join snwd_bpa as bpa
  on bpa.node_key = zcdsv_base.buyer_guid {
  key bpa.bp_id,
      bpa.company_name,
      zcdsv_base.currency_code,
      zcdsv_base.gross_amount
}
