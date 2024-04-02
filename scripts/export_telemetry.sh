#! /bin/bash

set -o errexit

# Configure below values before executing the script
CONTEXT=
NAMESPACE=
TELMETRY_DB_DSN=

ENCODED_DB_DSN=$(echo -n $TELMETRY_DB_DSN | base64)

kubectl config use-context $CONTEXT

awk -v db_dsn="$ENCODED_DB_DSN" '{gsub("_SUB_DB_DSN_", db_dsn)} 1' scripts/secret.yaml > temp && mv temp scripts/secret.yaml

echo "Starting job ..."
kubectl apply -f scripts/secret.yaml --namespace=$NAMESPACE
kubectl apply -f scripts/Job.yaml --namespace=$NAMESPACE 

echo "Waiting 120s until pod starts up ..."
sleep 120

pod=$(kubectl get pods --namespace=$NAMESPACE --output=jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | grep haic-telemetry-export)
echo "Running on $pod"

# wait until sql query execution is finished
while :
do
    VAR_VALUE=$(kubectl exec $pod --namespace=$NAMESPACE -- cat /workspace/TELEMETRY_EXPORT_STATUS)

    if [ "$VAR_VALUE" = "1" ]; then
        echo "sql query execution is finished."
        break
    else
        echo "sql query execution in progress. Waiting 5 seconds before checking again..."
        sleep 5
    fi
done

echo "Starting downloading telemetry data..."
mkdir data
kubectl cp --namespace=$NAMESPACE $pod:/workspace/data ./data
echo "Telemetry data download finished."

echo "Deleting job ..."
kubectl delete job haic-telemetry-export --namespace=$NAMESPACE
kubectl delete secret telemetry-db-secret --namespace=$NAMESPACE
