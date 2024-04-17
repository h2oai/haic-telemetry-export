# HAIC Telemetry Export


## Usage - Non Air Gapped Environment

### Prerequisites

- HAIC cluster should have a `postgres` telemetry database
- Make sure you have following installed
    - kubectl
- Make sure you have access to the cluster and you have updated the `kubeconfig` file accordingly.
    - [Authenticating to AWS EKS clusters](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)
    - [Authenticating to GCP GKE clusters](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl)
    - [Authenticating to Azure  AKS clusters](https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-get-credentials)

### Steps

1. Run the following command and telemetry data will be downloaded to the `data` directory.

```bash
curl https://raw.githubusercontent.com/h2oai/haic-telemetry-export/main/scripts/export_telemetry.sh | bash
```

### Usage - Air Gapped Environment

### Prerequisites

- HAIC cluster should have a `postgres` telemetry database
- Make sure you have following installed
    - kubectl

### Steps
A bundle can be provided for customers who have air-gapped clusters. Please [contact support team](https://h2o.ai/resources/support/) for assitance.

## What's Included in the Data

### Telemetry Table

Telemetry table contains following data.

| Column        | Description                                                                                                                               |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| `id`            | Unique ID for the entry                                                                                                                   |
| `ts`            | Timestamp                                                                                                                                 |
| `payload`       | Contains JSON representation of the payload. Refer [docs/payload](docs/payload.md) for more details                                       |
| `resource_type` | Supported resource types. Refer [docs/resource_type.md](docs/resource_type.md) for more details                                            |
| `resource_id`   | ID of the resource of the type listed                                                                                                     |
| `stream`        | Type of payload                                                                                                                           |
| `source`        | ID of the workload that emitted it                                                                                                        |
| `kind`          | Can be one of `0` - Unspecified, `1` - Event, & `2` - Gauge Metric                                                                        |
| `user_id`       | Keycloak subject (usually a uuid)                                                                                                         |
| `user_name`     | Keycloak preferred username (usually an email, users can change their email, but the id/uuid/subject stays constant and follows the user) |

- SQL queries related data can be found in [docs/sql.md](docs/sql.md)

__NOTE__: Sample data can be found in [sample-data](sample-data)

## FAQ

### 1. CSV files does not contain any data
There can be scenarios where data that matches the SQL query is not available in the telemetry database
