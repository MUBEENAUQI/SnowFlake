# Snowflake – Notes

## 1. What is Snowflake?
Snowflake is a **cloud-native data platform** designed for scalable data storage, processing, and analytics.

- Separates **storage and compute**, allowing multiple workloads to run independently on the same data without performance issues
- Fully managed (no infrastructure maintenance)
- Supports **structured and semi-structured data** (e.g., JSON)
- Key features include:
  - Automatic scaling
  - Time Travel
  - Secure data sharing

---

## 2. Why Snowflake over Traditional Databases?
Unlike traditional databases, Snowflake does **not require manual infrastructure management**.

Key advantages:
- Compute and storage are **decoupled**
- Better **scalability** and **concurrency**
- Improved **cost efficiency**
- Ideal for **modern cloud analytics workloads**

---

## 3. Data Loading
Refer to the following file for data loading examples:
- `Data_Loading.sql`

---

## 4. TastyBytes Dataset
Refer to the following file:
- `TasteyBytes.sql`

---

## 5. Snowflake Warehouses
**Virtual Warehouses** in Snowflake are independent compute clusters that provide the processing power to execute SQL queries.

- Handle computation only (querying, loading, transforming)
- Do **not** store data
- Multiple warehouses can access the same data simultaneously
- No performance impact between warehouses due to Snowflake’s compute-storage separation

Reference files:
- `warehouse.sql`
- `Warehouse_Tastybytes.sql`

---

## 6. Stages and Basic Ingestion
**Stages** in Snowflake are storage locations that act as an intermediary layer for loading and unloading data between Snowflake tables and storage.

- Can be **internal or external**
- Commonly used with `COPY INTO` commands
- Used for both data ingestion and export
![alt text](./images/types_of_internal_stages.png)
- named stages are referenced by [@stagename]
- For table stages [@%stagename]
- For user stages [@~stagename]
- refer stages_2.sql file and stages_1.sql

