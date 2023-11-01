@AbapCatalog.sqlViewAppendName: 'ZDDLS_CDS_13C'
extend view zcdsv_base with zcdsv_customer_extension {
  so.delivery_status,
  so.billing_status,
  so.created_at,
  so.created_by
}
