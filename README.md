# HAIC Telemetry Export

## User Guide

### Prerequisites

- Make sure you have following installed
    - kubectl
- Make sure you have access to the cluster and you have updated the `kubeconfig` file accordingly.

### Usage

1. Clone the repository
2. Edit the following values in `scripts/export_telemetry.sh`
    - `CONTEXT` - Context name for the cluster 
        - example for AWS: `arn:aws:eks:us-east-1:470338458334:cluster/abcd`
        - example for minikube: `minikube`
    - `NAMESPACE` - Namespace for the telemetry services
    - `TELMETRY_DB_DSN` - DSN for the telemetry database. example: `postgres://username:password@telemetry_database_name.rg2xcciz10ag.us-east-1.rds.amazonaws.com:5432/telemetry?sslmode=require`
3. Execute the shell script using following commands
```bash
    chmod +x ./scripts/export_telemetry.sh
    ./scripts/export_telemetry.sh
```
4. Telemetry data will be downloaded to the `data` directory.
