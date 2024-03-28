# HAIC Telemetry Export

## User Guide

### Prerequisites

- Make sure you have following installed
    - kubectl
    - AWS CLI
- Make sure you have access to the cluster and you have updated the `kubeconfig` file accordingly. You can use following command to update the `kubeconfig`.
```bash
aws eks --region <region> update-kubeconfig --name <cluster_name>
```
### Usage

1. Clone the repository
2. Edit the following values in `scripts/export_telemetry.sh`
    - `CONTEXT` - ARN of the cluster example: `arn:aws:eks:us-east-1:470338458334:cluster/abcd`
    - `NAMESPACE` - Namespace for the telemetry services
    - `TELMETRY_DB_DSN` - DSN for the telemetry database. example: `postgres://username:password@telemetry_database_name.rg2xcciz10ag.us-east-1.rds.amazonaws.com:5432/telemetry?sslmode=require`
3. Execute the shell script using following commands
```bash
    chmod +x ./scripts/export_telemetry.sh
    ./scripts/export_telemetry.sh
```
4. Telemetry data will be downloaded to the `data` directory.
