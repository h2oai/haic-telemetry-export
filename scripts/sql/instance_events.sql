WITH userNames (cloudUser) as (
    VALUES ('cloud-feedback@h2o.ai')
)
SELECT
    stream,
    user_name,
    payload AS label,
    ts
FROM userNames, telemetry
WHERE (
    stream = 'ai/h2o/cloud/appstore/instance/event/terminated' OR
    stream = 'ai/h2o/cloud/appstore/instance/event/started' OR
    stream = 'ai/h2o/cloud/appstore/instance/event/updated' OR
    stream = 'ai/h2o/cloud/appstore/instance/event/resumed' OR
    stream = 'ai/h2o/cloud/appstore/instance/event/suspended'
)
AND (NOT   (user_name = cloudUser))
