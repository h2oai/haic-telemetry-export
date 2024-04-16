# `payload`

Can be one of following.

1. API Event
    - Represents a single event related to an API call
    - Includes `service`, `method`, `status` & `latency` data
2. App Event
    - Can be one of following events
        - Create - Contains `App` & `AppRuntime` details
        - Delete - Contains `App` details
        - Update - Contains `App` & `App.Visibility` details
        - Preference Update - Contains `App` details for `liked`, `unliked`, `pinned` & `unpinned`
3. App Gauge
    - Represents a gauge metric relating to one or more HAC apps
    - If populated contains details `name` & `count` (includes only app versions with that name)
4. App Instance Event
    - Represents a single event related to a single or more HAC app instances
    - Contains only metadata, as the semantic meaning of the event is given by the `stream_id` of the enclosing entry
    - Can be one of following events
        - Started - Contains `App` & `AppInstance` details
        - Terminated - Contains `App` & `AppInstance` details
        - Suspended - Contains `App` & `AppInstance` details
        - Resumed - Contains `App` & `AppInstance` details
        - Updated - Contains `App`, `AppInstance` & `AppInstance.Visibility` details
5. App Instance Gauge
    - Represents a gauge metric relating to one or more HAC app instances
    - Contains `AppInstance`, `App`, `KubernetesResources`, & `KubernetesResourceUsage` details
6. Usage Gauge
    - Represents a gauge metric which contains all the important metrics to compute AI unit usage for billing
    - Contains `BillingResourceGauge` details
7. Empty Event
    - Represents of a single event that has no detailed information attached
    - This is the case for events where the header contains all the necessary information
8. Engine Event
    - Can be one of following events
        - Starting - Contains `Engine` details
        - Running - Contains `Engine` & `PodStatus` details
        - Pausing - Contains `Engine` details
        - Paused - Contains `Engine` details
        - Failed - Contains `Engine` & `PodFailure` details
        - Deleting - Contains `Engine` details
9. Feature Store Event
    - Each event consists of a message
    - Can be one of following events
        - Access - Contains `AccessEvent` details
        - Project - Contains `Project` details
            - Can be one of following events
            - Created
            - Updated
            - Deleted
            - Fetched
        - Feature Set - Contains `FeatureSet` details
            - Can be one of following events
            - Ingest
            - Retrieve
            - Preview
            - Compute Statistics
            - Materialization Online
            - Registration
            - Version
            - Update
        - Job
            - Can be one of following events
            - submitted - Contains `FeatureStoreJob`, `PodType`, `executors_number`, `FeatureStoreJobResources` details
            - running - Contains `FeatureStoreJob`, `PodType`, `executors_number`, `FeatureStoreJobResources`, `ExecutorStatistics` details
            - failed - Contains `FeatureStoreJob`, `PodType`, `executors_number`, `FeatureStoreJobResources` details 
            - success - Contains `FeatureStoreJob`, `PodType`, `executors_number`, `FeatureStoreJobResources` details
10. Example Event
    - Contains one of the following
    - Added - Contains `id` & `content` details
    - Updated - Contains `id` & `content` details
    - Deleted - Contains `id` & `content` details
    - Size Gauge - Contains `size_in_bytes` & `records_count`
    - Usage Gauge - Contains `downloads_count`
    - Collection - Contains `id`, `content`, & `sources`
11. MLOps Event
    - Contains one of following events
    - User Created - Contains `UserEnrolled` details
    - Project Created - Contains `ProjectCreated` details
    - Project Deleted - Contains `ProjectDeleted` details
    - Project Updated - Contains `ProjectUpdated` details
    - Project Shared - Contains `ProjectShared` details
    - Project Unshared - Contains `ProjectUnshared` details
    - Dataset Created - Contains `DatasetCreated` details
    - Dataset Deleted - Contains `DatasetDeleted` details
    - Dataset Linked - Contains `DatasetLinked` details
    - Dataset Unlinked - Contains `DatasetUnlinked` details
    - Experiment Created - Contains `ExperimentCreated` details
    - Experiment Deleted - Contains `ExperimentDeleted` details
    - Experiment Linked - Contains `ExperimentLinked` details
    - Experiment Unlinked - Contains `ExperimentUnlinked` details
    - Experiment Retrieved - Contains `ExperimentRetrieved` details
    - Create Registered Model - Contains `CreateRegisteredModel` details
    - Update Registered Model - Contains `UpdateRegisteredModel` details
    - Delete Registered Model - Contains `DeleteRegisteredModel` details
    - Create Registered Model Version - Contains `CreateRegisteredModelVersion` details
    - Delete Registered Model Version - Contains `DeleteRegisteredModelVersion` details
    - Deployment Created - Contains `DeploymentCreated` details
    - Deployment Deleted - Contains `DeploymentDeleted` details
    - Scoring Result Created - Contains `ScoringResultCreated` details
12. MLOps Gauge
    - Contains one of following
    - User Gauge - Contains `UserGauge` details
    - Project Gauge - Contains `ProjectGauge` details
    - Experiment Gauge - Contains `ExperimentGauge` details
    - Dataset Gauge - Contains `DatasetGauge` details
    - Registered Model Gauge - Contains `RegisteredModelGauge` details
    - Registered Model Version Gauge - Contains `RegisteredModelVersionGauge` details
    - Deployment Gauge - Contains `DeploymentGauge` details
13. Escorer Event
    - Contains `ScoringResultCreated` details
14. Document AI Event
    - Contains `DocumentAIEvent` details
15. App Store Event
    - Same as __App Event__
16. H2OGPTe Event
    - Contains one of following events
    - RPC Called - Contains `RPCCalled` details
    - API Called - Contains `APICalled` details
    - Job Started - Contains `JobStarted` details
    - Chat Joined - Contains `ChatJoined` details
    - Chat Left - Contains `ChatLeft` details
    - Chat Dropped - Contains `ChatDropped` details
    - Collection Created - Contains `CollectionCreated` details
    - Collection Updated - Contains `CollectionUpdated` details
    - Collection Deleted - Contains `CollectionDeleted` details
    - Collection Made Public - Contains `CollectionMadePublic` details
    - Collection Shared With User - Contains `CollectionSharedWithUser` details
    - Document Created - Contains `DocumentCreated` details
    - Document Deleted - Contains `DocumentDeleted` details
    - Chat Session Created - Contains `ChatSessionCreated` details
    - Chat Session Deleted - Contains `ChatSessionDeleted` details
    - Chat Message Created - Contains `ChatMessageCreated` details
    - Chat Message Received - Contains `ChatMessageReceived` details

## `App`
App represents a single App resource metadata.
App data holds following details
- `id`
- `created_at` - Timestamp
- `updated_at` - Timestamp
- `owner_name`
- `name`
- `version`
- `title`
- `description`
- `keywords`
- `visibility` - `App.Visibility`
- `tags` - `TagAssignment`

### `App.Visibility`
- `0` - Visibility unspecified
- `1` - Owner only
- `2` - All signed-in users

## `AppRuntime`
- `runtime_version`
- `module`
- `volume_size_bytes`
- `volume_mount`
- `resource_volume_size_bytes`
- `resources` - `KubernetesResources`
- `oidc_enabled` - Whether OpenID Connect is enabled
- `shm_enabled` - Whether shared memory is enabled

## `KubernetesResources`
- `memory_limit_bytes`
- `memory_reservation_bytes`
- `cpu_limit_millicpu`
- `gpu_count`
- `gpu_type`
- `storage_bytes`
- `storage_class`

## `KubernetesResourceUsage`
- `memory_bytes`
- `cpu_millicpu`

## `TagAssignment`
- `id`
- `assigned_at` - Timestamp
- `name`
- `title`
- `description`
- `visitor_roles`

## `AppInstance`
- `id`
- `created_at` - Timestamp
- `updated_at` - Timestamp
- `app_id`
- `visibility` - `AppInstance.Visibility`
- `location`
- `status` - `AppInstance.Status`
- `owner_id`
- `owner_name`
- `suspendable`

### `AppInstance.Visibility`
- `0` - Visibility unspecified
- `1` - Owner only (Private)
- `2` - All signed-in users
- `3` - Internet (Public)

### `AppInstance.Status`
- `0` - Status unspecified
- `1` - Status unknown
- `2` - Pending
- `3` - Deployed
- `4` - Failed
- `5` - Suspended

## `BillingResourceGauge`
- `memory_limit_bytes`
- `memory_reservation_bytes`
- `cpu_limit_millicpu`
- `cpu_reservation_millicpu`
- `gpu_count`
- `resources` - A resource is the primary resource of the platform - DAI, app instance, model deployment, etc. mostly these constitute 1 pod
- `padded_memory_reservation_bytes` - Some resources have no reservation or smaller than the minimum allowed by AI unit pricing model so in this sum those values with a min value
- `padded_cpu_reservation_millicpu` - Some resources have no reservation or smaller than the minimum allowed by AI unit pricing model so in this sum those values with a min value
- `gpu_types` - Aggregated amount of GPU within single GPU type (contains `type` & `count`)

## `Engine`
- `name` - Engine resource name
- `uid` - Globally unique identifier of the resource
- `creator` - Name of an entity that created the engine
- `creator_display_name` - Human readable creator name
- `type` - All possible engine types (contains `Engine.Type` details)
- `create_time` - Timestamp when the engine creation was requested
- `update_time` - Timestamp when the engine was last updated
- `resume_time` - Timestamp when the engine was last resumed or started for the first time
- `display_name` - Human readable name of the engine (contains at most 63 characters and is not unique)
- `version` - Version identifier
- `cpu` - Amount of CPU units in total requested by the engine
- `gpu` - Amount of GPU units in total requested by the engine
- `memory_bytes` - Amount of memory in bytes requested by this engine
- `storage_bytes` - Amount of storage in bytes requested by this engine
- `session` - UUID of a single run of the engine

### `Engine.Type`
- `0` - Type unspecified
- `1` - Driverless AI engine
- `2` - H2O engine


## `PodStatus`
Durations are represented as a signed, fixed-length span of time represented as a count of seconds and fractions of seconds at nanosecond resolution
- `pod_scheduled_duration`
- `containers_ready_duration`
- `initialized_duration`
- `ready_duration`
- `pull_time`

## `PodFailure`
- `reason`
- `message`

## `AccessEvent`
- `action` - `AccessEvent.ActionType`
- `type` - `AccessEvent.AccessedResource`
- `resource_id`
- `resource_name`
- `permission` - `AccessEvent.PermissionType`
- `receiver_id`

### `AccessEvent.ActionType`
- `0` - Action unspecified
- `1` - Grant
- `2` - Revoke

### `AccessEvent.AccessedResource`
- `0` - Access unspecified
- `1` - Project
- `2` - Feature Set

### `AccessEvent.PermissionType`
- `0` - Permission unspecified
- `1` - Owner
- `2` - Editor
- `3` - Consumer
- `4` - Sensitive Consumer

## `Project`
- `id`
- `name`
- `description`
- `create_time` - Timestamp
- `last_update_time` - Timestamp

## `FeatureSet`
- `id`
- `feature_set_name`
- `current_version`
- `project_id`
- `create_time` - Timestamp
- `last_update_time` - Timestamp

## `FeatureStoreJob`
- `id`
- `error_msg`
- `featureset_id`
- `labels` - Deprecated
- `job_labels`

## `PodType`
- `0` - Pod unspecified
- `1` - Driver
- `2` - Executor

## `FeatureStoreJobResources`
- `cpu_limit`
- `memory_byte_limit`

## `ExecutorStatistics`
- `count`
- `sum`
- `min_executors_number`
- `max_executors_number`
- `avg_executors_number`


## `UserEnrolled`
- `user` - `User`

## `ProjectCreated`
- `project` - `Project`

## `ProjectUpdated`
- `project` - `Project`

## `ProjectDeleted`
- `project` - `Project`

## `ProjectShared`
- `project` - `Project`
- `user_id`

## `ProjectUnshared`
- `project` - `Project`
 - - `user_id`

## `DatasetCreated`
- `dataset` - `Dataset`

## `DatasetDeleted`
- `dataset` - `Dataset`

## `DatasetLinked`
- `dataset` - `Dataset`
- `project` - `Project`

## `DatasetUnlinked`
- `dataset` - `Dataset`
- `project` - `Project`

## `ExperimentCreated`
- `experiment` - `Experiment`

## `ExperimentDeleted`
- `experiment` - `Experiment`

## `ExperimentRetrieved`
- `experiment` - `Experiment`
- `project` - `Project`

## `ExperimentLinked`
- `experiment` - `Experiment`
- `project` - `Project`

## `ExperimentUnlinked`
- `experiment` - `Experiment`
- `project` - `Project`

## `CreateRegisteredModel`
- `model` - `Model`

## `UpdateRegisteredModel`
- `model` - `Model`

## `DeleteRegisteredModel`
- `model` - `Model`

## `CreateRegisteredModelVersion`
- `model_version` - `ModelVersion`

## `DeleteRegisteredModelVersion`
- `model_version` - `ModelVersion`

## `User`
- `id`

## `Project`
- `id`
- `display_name`

## `Dataset`
- `id`
- `project_id`
- `display_name`
- `size`
- `row_count`
- `column_count`

## `Experiment`
- `id`
- `project_id`
- `display_name`
- `target_column`
- `weight_column`
- `fold_column`
- `training_duration`
- `status`
- `training_dataset_id`
- `validation_dataset_id`
- `test_dataset_id`

## `Model`
- `id`
- `project_id`
- `display_name`

## `ModelVersion`
- `id`
- `version_number`
- `project_id`
- `model` - `Model`
- `experiment` - `Experiment`

## `DeploymentCreated`
- `deployment` - `Deployment`

## `DeploymentDeleted`
- `deployment` - `Deployment`

## `DeploymentMode`
- `0` - Deployment mode unspecified
- `1` - Single
- `2` - Champion Challenger
- `3` - A/B Testing

## `DeploymentType`
- `0` - Deployment type unspecified
- `1` - Realtime
- `2` - Batch

## `DeploymentEnvironment`
- `id`
- `display_name`

## `DeploymentSpecs`
- `model_version` - `ModelVersion`
- `artifact_type`
- `runtime`
- `k8s_resources`

## `Deployment`
- `id`
- `display_name`
- `model_version` - `ModelVersion`
- `environment` - `DeploymentEnvironment`
- `mode` - `DeploymentMode`
- `type` - `DeploymentType`
- `deployment_specs` - `DeploymentSpecs`

## `ScoringResultCreated`
- `scoring_details` - `ScoringDetails`
- `deployment` - `Deployment`
- `artifact_type`

## `UserGauge`
- `total_count`

## `ProjectGauge`
- `total_count`

## `ExperimentGauge`
- `total_count`
- `failed_count`
- `aborted_count`

## `DatasetGauge`
- `total_count`

## `RegisteredModelGauge`
- `total_count`

## `RegisteredModelVersionGauge`
- `total_count`
- `active_count`
- `inactive_count`

## `DeploymentGauge`
- `total_count`
- `single_model_count`
- `shadow_traffic_count`
- `split_traffic_count`

## `EScorerEvent`
- `scoring_created` - `ScoringResultCreated`

## `ScoringResultCreated`
- `scoring_details`
- `customer_id`
- `model_name`
- `deployments_count`
- `training_details` - `TrainingDetails`
- `host_name`
- `latency_details` - `LatencyDetails`
- `error_details` - `ErrorDetails`

## `ErrorDetails`
- `error_count`
- `last_error_msg`

## `LatencyDetails`
- `latency_total`
- `latency_ave`

## `TrainingDetails`
- `source`
- `version`

## `DocumentAIEvent`
- `scored` - `ScoreEvent`

## `ScoreEvent`
- `num_pages_scored`
- `pipeline_name`

## `RPCCalled`
- `user` - `User`
- `method`
- `response_time`

## `User`
- `id`
- `name`

## `Collection`
- `id`

## `Document`
- `id`

## `ChatSession`
- `id`

## `APICalled`
- `user` - `User`
- `method`
- `response_time`
- `response_code`

## `JobStarted`
- `user` - `User`
- `method`
- `response_time`
- `error_text`

## `ChatJoined`
- `user` - `User`

## `ChatLeft`
- `user` - `User`

## `ChatDropped`
- `user` - `User`

## `CollectionCreated`
- `user` - `User`
- `collection` - `Collection`

## `CollectionUpdated`
- `user` - `User`
- `collection` - `Collection`

## `CollectionDeleted`
- `user` - `User`
- `collection` - `Collection`

## `CollectionMadePublic`
- `user` - `User`
- `collection` - `Collection`

## `CollectionSharedWithUser`
- `user` - `User`
- `collection` - `Collection`
- `with_user`

## `DocumentCreated`
- `user` - `User`
- `collection` - `Collection`
- `upload_id`

## `DocumentDeleted`
- `user` - `User`
- `collection` - `Collection`
- `document` - `Document`

## `ChatSessionCreated`
- `user` - `User`
- `collection` - `Collection`
- `chat_session` - `ChatSession`

## `ChatSessionDeleted`
- `user` - `User`
- `collection` - `Collection`
- `chat_session` - `ChatSession`

## `ChatMessageCreated`
- `user` - `User`
- `collection` - `Collection`
- `chat_session` - `ChatSession`

## `ChatMessageReceived`
- `user` - `User`
- `collection` - `Collection`
- `chat_session` - `ChatSession`
- `usage` - `LLMUsage`

## `LLMUsage`
- `llm`
- `input_tokens`
- `output_tokens`
- `description`
