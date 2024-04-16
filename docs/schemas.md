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
        - Project - 
        - Feature Set
        - Job
10. Example Event
11. MLOps Event
12. MLOps Gauge
13. Escorer Event
14. Document AI Event
15. App Store Event
16. H2OGPTe Event

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
- `0`
- `1`
- `2`
