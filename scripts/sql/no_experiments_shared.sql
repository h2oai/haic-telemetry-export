SELECT *
FROM telemetry
WHERE payload->'mlopsEvent'->'projectShared' IS NOT NULL;
