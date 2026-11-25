select
  session_id,
  cast(customer_id as integer) as customer_id,
  cast(session_date as date) as session_date,
  lower(source) as source,
  lower(device) as device
from {{ source('raw', 'sessions') }}
