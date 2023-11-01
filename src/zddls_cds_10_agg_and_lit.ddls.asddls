@AbapCatalog.sqlViewName: 'ZDDLS_CDS_10'
define view zcdsv_aggregations
as select from snwd_so as so
inner join snwd_bpa as bpa
on so.buyer_guid = bpa.node_key {
  key bpa.bp_id as customer_id,
      bpa.company_name,
      'Literal' as string_literal,
      42 as integer_literal,
      so.currency_code,
      sum( so.gross_amount ) as total_gross_amount
}
group by
    bpa.bp_id,
    bpa.company_name,
    so.currency_code 
having sum( so.gross_amount ) > 1000
