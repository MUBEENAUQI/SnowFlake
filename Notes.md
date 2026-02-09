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
- refer stages_2.sql file and stages_1.sql and stages_Pratctice

## 7. Database and Schema

### Database

* A **database** in Snowflake is a logical container used to organize schemas and database objects.
* It provides isolation, access control, and structure for data.
* One Snowflake account can have multiple databases.

### Schema

* A **schema** is a logical grouping of database objects like tables, views, stages, and functions.
* Schemas exist **inside a database**.
* Used to organize objects and control access.

### Tables

* Tables store structured data in rows and columns.
* Snowflake automatically manages storage, indexing, and optimization.


### Key Interview Points

* Database → top-level container
* Schema → logical grouping inside database
* Tables → store actual data
* Separation helps with security, organization, and access control

----

## 14. Snowflake Table Data Types (Interview-Critical)

Snowflake supports flexible, cloud-native data types. Many data types auto-scale, reducing schema rigidity compared to traditional databases.

---

### Numeric Data Types
```sql
NUMBER        -- Generic numeric (recommended)
NUMBER(10,2)  -- Precision and scale
INT           -- Integer values
FLOAT         -- Approximate numeric values

Interview tip:
NUMBER is preferred because it is flexible and avoids precision issues unless explicitly required.

String Data Types
STRING        -- Most commonly used
VARCHAR       -- Same as STRING
TEXT          -- Same as STRING

Key point:
Snowflake does not enforce strict length limits like VARCHAR(50) in traditional databases.

Date & Time Data Types
DATE
TIME
TIMESTAMP_NTZ  -- No timezone (most common)
TIMESTAMP_LTZ  -- Local timezone
TIMESTAMP_TZ   -- Timezone-aware

Interview tip:
TIMESTAMP_NTZ is preferred for analytics and reporting because it avoids timezone conversion complexity.

Boolean Data Type
BOOLEAN  -- TRUE / FALSE
Semi-Structured Data Types (Key Snowflake Advantage)
VARIANT  -- JSON, XML, Parquet
ARRAY
OBJECT

Why this matters:
Snowflake can query semi-structured data without flattening or schema changes.

Interview One-Liner

Snowflake handles both structured and semi-structured data seamlessly using the VARIANT data type, which is a major advantage over traditional data warehouses.


## 15. Snowflake Views (Interview-Critical)

A **view** in Snowflake is a stored SQL query that provides a logical layer over tables.  
Views **do not store data** — they always read from the underlying tables.

---

### Why Use Views?
- Simplify complex queries
- Hide sensitive columns (security)
- Provide a consistent interface for analytics
- Reduce duplication of business logic
