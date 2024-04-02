WITH ai_units_constants (ram_gi_per_ai_unit_hours, cpu_per_ai_unit_hours, gpu_per_ai_unit_hours) as (
  values (64.0, 8.0, 4.0)
)
SELECT
  time_interval,
  resource,
  ram_gi, ram_gi / ram_gi_per_ai_unit_hours as ram_gi_ai_unit_hours,
  cpu, cpu / cpu_per_ai_unit_hours as cpu_ai_unit_hours,
  gpu, gpu / gpu_per_ai_unit_hours as gpu_ai_unit_hours,
  GREATEST((GREATEST((ram_gi / ram_gi_per_ai_unit_hours), (cpu / cpu_per_ai_unit_hours)) - gpu), 0) + (gpu * gpu_per_ai_unit_hours) as ai_units
FROM ai_units_constants, (
  SELECT
      DATE_TRUNC('hour', ts) AS time_interval,
      regexp_replace(regexp_replace(resource_id, '^.*:', ''), '-.*$', '') as resource,
      COALESCE(MAX((payload->'usageGauge'->'billingResources'->>'paddedMemoryReservationBytes')::bigint/1024.0/1024.0/1024.0), 0) AS ram_gi,
      COALESCE(MAX((payload->'usageGauge'->'billingResources'->'paddedCpuReservationMillicpu')::int/1000.0), 0) AS cpu,
      COALESCE(MAX((payload->'usageGauge'->'billingResources'->'gpuCount')::int), 0) AS gpu
    FROM telemetry
    WHERE stream = 'ai/h2o/cloud/usage/namespace/gauge/resources'
    GROUP BY 1, 2
  ) AS x
