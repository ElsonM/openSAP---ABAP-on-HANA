@AbapCatalog.sqlViewName: 'ZDDLS_CDS_11'
define view zcdsv_arithmetics
as select from snwd_so as so
inner join snwd_bpa as bpa
on so.buyer_guid = bpa.node_key {
  key bpa.bp_id as customer_id,
      bpa.company_name,
      so.currency_code,
      ( so.gross_amount - so.net_amount ) as tax_amount,
      0.85 * cast( so.gross_amount as abap.fltp ) as reduced_gross_amount
}
