WITH userNames (cloudUser) as (
    VALUES ('cloud-feedback@h2o.ai')
)
SELECT
    stream,
    user_name,
    payload AS label,
    ts
FROM userNames, telemetry
WHERE stream like 'ai/h2o/cloud/appstore/app/event/%'
AND (NOT   (user_name = cloudUser))
