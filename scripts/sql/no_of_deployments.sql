SELECT COUNT(DISTINCT payload->'mlopsEvent'->'deploymentCreated'->'deployment'->>'id') AS unique_deployment_count 
FROM telemetry 
WHERE payload->'mlopsEvent'->>'operationCode' = 'DEPLOY';
