@AbapCatalog.sqlViewName: 'ZDDLS_CDS_14A'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View with Input Parameters'
define view zcdsv_with_input_parameters 
  with parameters customer_name : abap.char(80) 
  as select from snwd_so as so
  join snwd_bpa as bpa on bpa.node_key = so.buyer_guid {
  
  key so.so_id as order_id,
      $parameters.customer_name as param_customer_name,
      case 
        when bpa.company_name = $parameters.customer_name 
          then 'Found it!'
        else                                                     
          'Not found'
      end as found_customer                   
}
  where bpa.company_name = $parameters.customer_name
