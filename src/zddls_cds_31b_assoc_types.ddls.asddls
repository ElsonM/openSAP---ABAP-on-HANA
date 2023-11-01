@AbapCatalog.sqlViewName: 'ZDDLS_CDS_31B'
define view zcdsv_assoc_types_consumption as
  select from zcdsv_assoc_types { 
  zcdsv_assoc_types.business_partners.bp_id
}
