with session_summary as (
  select customer_id, count(*) as sessions,
         min(session_date) as first_session,
         max(session_date) as last_session
  from {{ ref('stg_sessions') }}
  group by customer_id
),
order_summary as (
  select customer_id, count(*) as orders,
         sum(revenue) as lifetime_revenue,
         max(order_date) as last_order_date
  from {{ source('raw', 'orders') }}
  group by customer_id
)
select c.customer_id, c.customer_name, c.region,
       coalesce(s.sessions, 0) as sessions,
       coalesce(o.orders, 0) as orders,
       coalesce(o.lifetime_revenue, 0) as lifetime_revenue,
       s.first_session, s.last_session, o.last_order_date
from {{ source('raw', 'crm_customers') }} c
left join session_summary s using (customer_id)
left join order_summary o using (customer_id)
