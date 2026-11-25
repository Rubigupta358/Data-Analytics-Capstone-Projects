-- Public GA4 sample: bigquery-public-data.ga4_obfuscated_sample_ecommerce
-- Example daily session-level source extraction. Run in BigQuery.
SELECT
  event_date,
  user_pseudo_id,
  (SELECT value.int_value FROM UNNEST(event_params) WHERE key='ga_session_id') AS ga_session_id,
  traffic_source.source AS source,
  traffic_source.medium AS medium,
  device.category AS device_category,
  geo.country AS country,
  event_name
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131';
