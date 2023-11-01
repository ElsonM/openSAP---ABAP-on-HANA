@AbapCatalog.sqlViewName: 'ZDDLS_CDS_33B'
define view zcdsv_adv_filter_example_l1
as select from snwd_pd as pd
association [1..*] to zcdsv_adv_filter_example_base as texts    
  on $projection.text_guid = texts.product_text_guid
{
 key pd.product_id,
     pd.desc_guid as text_guid,
     texts
}
