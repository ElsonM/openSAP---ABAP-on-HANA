@AbapCatalog.sqlViewName: 'ZDDLS_CDS_33C'
define view zcdsv_adv_filter_example_l2
with parameters lang : abap.lang
as select from zcdsv_adv_filter_example_l1 as product
{
  $parameters.lang as langu_filter_param,
  coalesce ( product.texts[1: language = $parameters.lang ].text,
             product.texts[1: language = 'E'              ].text ) as product_description
}
