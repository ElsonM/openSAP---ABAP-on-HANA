@AbapCatalog.sqlViewName: 'ZDDLS_CDS_00'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Simple CDS View'
define view zcdsv_simple as select from snwd_so {
  snwd_so.so_id as order_id,
  snwd_so.gross_amount,
  snwd_so.currency_code
}
