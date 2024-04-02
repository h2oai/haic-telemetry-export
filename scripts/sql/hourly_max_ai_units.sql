WITH ai_units_constants (ram_gi_per_ai_unit_hours, cpu_per_ai_unit_hours, gpu_per_ai_unit_hours) as (
  values (64.0, 8.0, 4.0)
)
SELECT
  hour AS time_interval,
  GREATEST((GREATEST((ram_gi / ram_gi_per_ai_unit_hours), (cpu / cpu_per_ai_unit_hours)) - gpu), 0) + (gpu * gpu_per_ai_unit_hours) as ai_units
FROM ai_units_constants, (
  SELECT
      -- This is a gauge stream, meaning multiple sources are exporting duplicate entries during the same hour interval
      DATE_TRUNC('hour', ts) AS hour,
      -- RAM usage in Gi
      COALESCE(MAX((payload->'usageGauge'->'billingResources'->>'paddedMemoryReservationBytes')::bigint/1024.0/1024.0/1024.0), 0) AS ram_gi,
      -- CPU usage in vCPU
      COALESCE(MAX((payload->'usageGauge'->'billingResources'->'paddedCpuReservationMillicpu')::int/1000.0), 0) AS cpu,
      -- GPU usage in number of GPUs
      --TODO: why is it max in an hour and not sum???
      COALESCE(MAX((payload->'usageGauge'->'billingResources'->'gpuCount')::int), 0) AS gpu
    FROM telemetry
    WHERE stream = 'ai/h2o/cloud/usage/global/gauge/resources'
    GROUP BY 1
  ) AS internal
ORDER BY 1 DESC;
