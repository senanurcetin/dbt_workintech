{{ config(materialized='view') }}

select
    fd.date_date as date,
    round(fd.operational_margin - coalesce(icd.ads_cost, 0), 2) as ads_margin,
    round(fd.avg_basket, 2) as average_basket,
    round(fd.operational_margin, 2) as operational_margin,
    round(coalesce(icd.ads_cost, 0), 2) as ads_cost,
    coalesce(icd.ads_impression, 0) as ads_impression,
    coalesce(icd.ads_clicks, 0) as ads_clicks,
    fd.total_quantity as quantity,
    round(fd.total_revenue, 2) as revenue,
    round(fd.total_purchase_cost, 2) as purchase_cost,
    round(fd.total_revenue - fd.total_purchase_cost, 2) as margin,
    round(fd.total_shipping_fee, 2) as shipping_fee,
    round(fd.total_log_cost, 2) as log_cost,
    round(fd.total_ship_cost, 2) as ship_cost
from {{ ref('finance_days') }} as fd
left join {{ ref('int_campaigns_day') }} as icd
    on fd.date_date = icd.date_date
order by date desc