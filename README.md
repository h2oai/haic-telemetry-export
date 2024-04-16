# HAIC Telemetry Export


## Usage - Non Air Gapped Environment

### Prerequisites

- Make sure you have following installed
    - kubectl
- Make sure you have access to the cluster and you have updated the `kubeconfig` file accordingly.
    - [Authenticating to AWS EKS clusters](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)
    - [Authenticating to GCP GKE clusters](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl)
    - [Authenticating to Azure  AKS clusters](https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-get-credentials)

### Steps

1. Clone the repository using following command and goto the directory.
```bash
git clone https://github.com/h2oai/haic-telemetry-export.git \
    && cd haic-telemetry-export
```
2. Edit the following values in `scripts/export_telemetry.sh`
    - `CONTEXT` - Context name for the cluster

        You can use following command to list the available contexts
        ```bash
        kubectl config get-contexts
        ``` 
        - example for AWS: `arn:aws:eks:us-east-1:470338458334:cluster/abcd`
        - example for GCP: `gke_my_project_us-central1-abcd`
        - example for Azure: `aks_abcd`
        - example for minikube: `minikube`
    - `NAMESPACE` - Namespace for the telemetry services
        - example: `telemetry`
    - `TELMETRY_DB_DSN` - Database Source Name (DSN) for the telemetry database

       DSN requires `username`, `password`, `hostname`, `port`, & `database_name` as specified below.
        - example: `postgres://username:password@hostname:port/database_name?sslmode=require`
3. Execute the shell script using following commands
```bash
    chmod +x ./scripts/export_telemetry.sh
    ./scripts/export_telemetry.sh
```
4. Telemetry data will be downloaded to the `data` directory.

### Usage - Air Gapped Environment

### Prerequisites

- Make sure you have following installed
    - kubectl

### Steps
1. Clone the repository using following command and goto the directory.
```bash
git clone https://github.com/h2oai/haic-telemetry-export.git \
    && cd haic-telemetry-export
```

2. Build the runtime docker image using following command
```bash
docker build -t haic-telemetry-exporter -f Dockerfile . 
```
__NOTE__:If above 2 steps cannot be executed, bundled Docker image & repository can be provided.

3. Change the image value of `scripts/Job.yaml` to `haic-telemetry-exporter`.

```diff
-   image: gcr.io/vorvan/h2oai/haic-telemetry-exporter:latest
+  haic-telemetry-exporter
```

4. Edit the following values in `scripts/export_telemetry.sh`
    - `CONTEXT` - Context name for the cluster
    
        You can use following command to list the available contexts
        ```bash
        kubectl config get-contexts
        ``` 
    - `NAMESPACE` - Namespace for the telemetry services
        - example: `telemetry`
    - `TELMETRY_DB_DSN` - Database Source Name (DSN) for the telemetry database
        
        DSN requires `username`, `password`, `hostname`, `port`, & `database_name` as specified below.
        - example: `postgres://username:password@hostname:port/database_name?sslmode=require`
5. Execute the shell script using following commands
```bash
    chmod +x ./scripts/export_telemetry.sh
    ./scripts/export_telemetry.sh
```
6. Telemetry data will be downloaded to the `data` directory.

## What's Included in the Data

### Telemetry Table

Telemetry table contains following data.

| Column        | Description                                                                                                                               |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| `id`            | Unique ID for the entry                                                                                                                   |
| `ts`            | Timestamp                                                                                                                                 |
| `payload`       |                                                                                                                                           |
| `resource_type` |                                                                                                                                           |
| `resource_id`   | ID of the resource of the type listed                                                                                                     |
| `stream`        | Type of payload                                                                                                                           |
| `source`        |                                                                                                                                           |
| `kind`          |                                                                                                                                           |
| `user_id`       | Keycloak subject (usually a uuid)                                                                                                         |
| `user_name`     | Keycloak preferred username (usually an email, users can change their email, but the id/uuid/subject stays constant and follows the user) |

