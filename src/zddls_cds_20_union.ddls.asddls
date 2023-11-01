@AbapCatalog.sqlViewName: 'ZDDLS_CDS_20'
define view zcdsv_union as
select from snwd_so as so
  inner join snwd_bpa as bpa 
     on so.buyer_guid = bpa.node_key { 
  key bpa.bp_id,
      bpa.company_name,
      sum( gross_amount ) as total_gross_amount,
      'Small' as category
}
group by bpa.bp_id, bpa.company_name
having sum( gross_amount ) < 10000000
 
union all 
 
select from snwd_so as so
  inner join snwd_bpa as bpa 
     on so.buyer_guid = bpa.node_key { 
  key bpa.bp_id,
      bpa.company_name,
      sum( gross_amount ) as total_gross_amount,
      'Large' as category
}
group by bpa.bp_id, bpa.company_name
having sum( gross_amount ) >= 10000000  
