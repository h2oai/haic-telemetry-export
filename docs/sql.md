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

## 3. `app_events.sql`

## 4. `hourly_consumption_details.sql`

## 5. `hourly_max_ai_units_cat.sql`

## 6. `hourly_max_ai_units.sql`

## 7. `instance_events.sql`

## 8. `user_login_data.sql`

Retrieves data related to user login events from the app store.