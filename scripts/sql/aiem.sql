select
    ts,
    stream,
    user_name,
    engineName,
    type,
    version,
    cpu,
    memory,
    gpu,
    storage,
    GREATEST((GREATEST((usage_ram / 64.0), (usage_cpu / 8.0)) - usage_gpu), 0) + (usage_gpu * 4.0) as ai_units
from (
    select
        ts,
        stream,
        user_name,
        COALESCE(payload->'engineEvent'->'starting'->'engine'->>'name', payload->'engineEvent'->'pausing'->'engine'->>'name', payload->'engineEvent'->'deleting'->'engine'->>'name', 'N/A') AS engineName,
        COALESCE(payload->'engineEvent'->'starting'->'engine'->>'type', payload->'engineEvent'->'pausing'->'engine'->>'type', payload->'engineEvent'->'deleting'->'engine'->>'type', 'N/A') AS type,
        COALESCE(payload->'engineEvent'->'starting'->'engine'->>'version', payload->'engineEvent'->'pausing'->'engine'->>'version', payload->'engineEvent'->'deleting'->'engine'->>'version', 'N/A') AS version,
        COALESCE(cast(payload->'engineEvent'->'starting'->'engine'->>'cpu' as int), cast(payload->'engineEvent'->'pausing'->'engine'->>'cpu' as int), cast(payload->'engineEvent'->'deleting'->'engine'->>'cpu' as int), 0) AS cpu,
        COALESCE(cast(payload->'engineEvent'->'starting'->'engine'->>'memoryBytes' as bigint)/1024.0/1024.0/1024.0, cast(payload->'engineEvent'->'pausing'->'engine'->>'memoryBytes' as bigint)/1024.0/1024.0/1024.0, cast(payload->'engineEvent'->'deleting'->'engine'->>'memoryBytes' as bigint)/1024.0/1024.0/1024.0, 0) AS memory,
        COALESCE(cast(payload->'engineEvent'->'starting'->'engine'->>'gpu' as int), cast(payload->'engineEvent'->'pausing'->'engine'->>'gpu' as int), cast(payload->'engineEvent'->'deleting'->'engine'->>'gpu' as int), 0) AS gpu,
        COALESCE(cast(payload->'engineEvent'->'starting'->'engine'->>'storageBytes' as bigint)/1024.0/1024.0/1024.0, cast(payload->'engineEvent'->'pausing'->'engine'->>'storageBytes' as bigint)/1024.0/1024.0/1024.0, cast(payload->'engineEvent'->'deleting'->'engine'->>'storageBytes' as bigint)/1024.0/1024.0/1024.0, 0) AS storage,
        COALESCE(cast(payload->'engineEvent'->'starting'->'engine'->>'memoryBytes' as double precision)/1024.0/1024.0/1024.0, cast(payload->'engineEvent'->'pausing'->'engine'->>'memoryBytes' as double precision)/1024.0/1024.0/1024.0, cast(payload->'engineEvent'->'deleting'->'engine'->>'memoryBytes' as double precision)/1024.0/1024.0/1024.0, 0) AS usage_ram,
        COALESCE(cast(payload->'engineEvent'->'starting'->'engine'->>'cpu' as int), cast(payload->'engineEvent'->'pausing'->'engine'->>'cpu' as int), cast(payload->'engineEvent'->'deleting'->'engine'->>'cpu' as int), 0) AS usage_cpu,
        COALESCE(cast(payload->'engineEvent'->'starting'->'engine'->>'gpu' as int), cast(payload->'engineEvent'->'pausing'->'engine'->>'gpu' as int), cast(payload->'engineEvent'->'deleting'->'engine'->>'gpu' as int), 0) AS usage_gpu
    from telemetry
    where stream like 'ai/h2o/engine/%'
    AND (payload->'engineEvent'->'starting' IS NOT NULL OR payload->'engineEvent'->'pausing' IS NOT NULL OR payload->'engineEvent'->'deleting' IS NOT NULL)
) as aiem
