@AbapCatalog.sqlViewName: 'ZDDLS_CDS_33A'
define view zcdsv_adv_filter_example_base
as select from snwd_texts
{
  parent_key as product_text_guid,
  language,
  text
}
