#! /bin/bash

set -o errexit

SECRET_NAME=$(kubectl get secret -n telemetry | grep 'telemetry-secrets' | awk '{print $1}')

cat <<EOF > Job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: haic-telemetry-export
spec:
  template:
    metadata:
      name: haic-telemetry-export
    spec:
      restartPolicy: OnFailure
      containers:
      - name: haic-telemetry-export-runtime
        image: gcr.io/vorvan/h2oai/haic-telemetry-exporter:v1.0.0
        env:
          - name: DB_DSN
            valueFrom:
              secretKeyRef:
                name: $SECRET_NAME
                key: dsn
        imagePullPolicy: Always
EOF

CONTEXT=$(kubectl config current-context)
NAMESPACE=$(kubectl get namespace | grep "telemetry" | awk '{print $1}')

if [ -n "$NAMESPACE" ]; then
    echo "Namespace 'telemetry' exists" 
else 
    echo "Namespace 'telemetry' does not exist." 
fi

echo "Starting job ..."
kubectl apply -f Job.yaml --namespace=$NAMESPACE 

echo "Waiting 120s until pod starts up ..."
sleep 120

pod=$(kubectl get pods --namespace=$NAMESPACE --output=jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | grep haic-telemetry-export)
echo "Running on $pod"

# wait until sql query execution is finished
while :
do
    VAR_VALUE=$(kubectl exec $pod --container=haic-telemetry-export-runtime --namespace=$NAMESPACE -- cat /workspace/TELEMETRY_EXPORT_STATUS)

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
kubectl cp --container=haic-telemetry-export-runtime --namespace=$NAMESPACE $pod:/workspace/data ./data
echo "Telemetry data download finished."

echo "Deleting job ..."
kubectl delete job haic-telemetry-export --namespace=$NAMESPACE
