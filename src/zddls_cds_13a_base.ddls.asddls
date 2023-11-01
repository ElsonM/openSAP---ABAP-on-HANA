@AbapCatalog.sqlViewName: 'ZDDLS_CDS_13A'
define view zcdsv_base as select
  from snwd_so as so {
  key so.so_id as order_id,
      so.buyer_guid,
      so.currency_code,
      so.gross_amount
}
