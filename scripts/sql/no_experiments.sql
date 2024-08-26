SELECT *
FROM telemetry
WHERE payload->'mlopsEvent'->'projectCreated' IS NOT NULL;
