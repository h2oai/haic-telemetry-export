select
    hour,
    resource,
    GREATEST((GREATEST((ram_gi / 64.0), (cpu / 8.0)) - gpu), 0) + (gpu * 4.0) as ai_units
from (
    select
        date_trunc('hour', ts) as hour,
        regexp_replace(regexp_replace(resource_id, '^.*:', ''), '-.*$', '') as resource,
        COALESCE(MAX(cast(payload->'usageGauge'->'billingResources'->>'paddedMemoryReservationBytes' as bigint)/1024.0/1024.0/1024.0), 0) AS ram_gi,
        COALESCE(MAX(cast(payload->'usageGauge'->'billingResources'->'paddedCpuReservationMillicpu' as int)/1000.0), 0) AS cpu,
        COALESCE(MAX(cast(payload->'usageGauge'->'billingResources'->'gpuCount' as int)), 0) AS gpu
        from telemetry
        WHERE stream = 'ai/h2o/cloud/usage/namespace/gauge/resources'
        group by 1,2
    ) as hourly
ORDER BY 1 DESC, 2 ASC
