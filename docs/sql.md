# SQL Queries

This section contains details for what type of data is retrieved by each of the sql queries included in `scripts/sql`.

## 1. `ai_unit_hourly.sql`

Calculates the number of `ai_units` used by each [resource] hourly.

Given that:
- **ram_gi**: RAM in Gigabytes
- **cpu**: CPU units (converted from millicpus to CPU units in the precursor step)
- **gpu**: Count of GPUs

Number of `ai units` is calculated as follows
$$ai\_units = \max\left(\max\left(\frac{ram\_gi}{64}, \frac{cpu}{8}\right) - gpu, 0\right) + (gpu \times 4)$$ 

## 2. `aiem.sql`

Calculates the `resource utilization` used by each `engine` hourly

Given that:
- **stream**: One of value `starting` / `pausing` / `deleting`
- **user_name**: 
- **enginename**: Name of the engine
- **type**: Type of the engine
- **version**: Version
- **cpu**: CPU units (converted from millicpus to CPU units in the precursor step)
- **gpu**: Count of GPUs
- **memory**: Memory usage in GB
- **storage**: Storage usage in GB

Number of `ai units` is calculated as follows
$$ai\_units = \max\left(\max\left(\frac{ram\_gi}{64}, \frac{cpu}{8}\right) - gpu, 0\right) + (gpu \times 4)$$ 

## 3. `app_events.sql`

Returns telemetry data for `app events`

Given that:
- **stream**: stream of the app event
- **username**: 
- **label**: payload data
- **ts**: timestamp

## 4. `hourly_consumption_details.sql`

Calculates hourly hardware resource utilization by `resources`

Given that:
- **hour**: calculated hour
- **resource**: resource name
- **ram_gi**: RAM in Gigabytes
- **ram_gi_ai_unit_hours**: $$ram\_gi\_ai\_unit\_hours=\frac{ram\_gi}{64}$$
- **cpu**: CPU units (converted from millicpus to CPU units in the precursor step)
- **cpu_ai_unit_hours**: $$cpu\_ai\_unit\_hours=\frac{cpu}{8}$$
- **gpu**: Count of GPUs
- **gpu_ai_unit_hours**: $$cpu\_ai\_unit\_hours={gpu}\times{8}$$
- **ai_units** $$ai\_units = \max\left(\max\left(\frac{ram\_gi}{64}, \frac{cpu}{8}\right) - gpu, 0\right) + (gpu \times 4)$$ 

## 5. `hourly_max_ai_units_cat.sql`



## 6. `hourly_max_ai_units.sql`

Calculates the maximum ai_units utilized hourly

Given that:

- **time_interval**: Calculated hour
- **ai_units**:
$$ai\_units = \max\left(\left(\max\left(\left(\frac{ram\_gi} {ram\_gi\_per\_ai\_unit\_hours}\right), \left(\frac{cpu}{cpu\_per\_ai\_unit\_hours}\right)\right) - gpu\right), 0\right) + \left(gpu \times gpu\_per\_ai\_unit\_hours\right)$$ 

## 7. `instance_events.sql`

## 8. `user_login_data.sql`

Retrieves data related to user login events from the app store.