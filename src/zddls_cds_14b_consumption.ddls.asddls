@AbapCatalog.sqlViewName: 'ZDDLS_CDS_14B'
define view zcdsv_consume_param_view 
as select from zcdsv_with_input_parameters( customer_name : 'SAP' ) as vwp {
  vwp.param_customer_name                   
}
