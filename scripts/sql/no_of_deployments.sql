SELECT *
FROM telemetry 
WHERE payload->'mlopsEvent'->>'operationCode' = 'DEPLOY';
