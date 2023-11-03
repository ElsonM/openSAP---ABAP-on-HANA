@AbapCatalog.sqlViewName: 'ZDDLS_CDS_40'
@ClientDependent: true
@AbapCatalog.buffering.status: #SWITCHED_OFF
define view zcdsv_annotation_simple as select from snwd_so
{
  key so_id as customer_id, 
      @Semantics.currencyCode: true
      currency_code,
      @Semantics.amount.currencyCode: 'currency_code'
      gross_amount
}
