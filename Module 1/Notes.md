# Snowflake – Interview Notes

These notes are **interview-focused**. SQL implementation is kept in separate `.sql` files, so this document explains **concepts, why they matter, and how to speak about them confidently**.

---

## 1. What is Snowflake?

Snowflake is a **cloud-native data platform** primarily used for data warehousing, analytics, and secure data sharing.

What makes Snowflake different:

* Built **only for the cloud** (AWS, Azure, GCP)
* Fully managed (no servers, no tuning, no maintenance)
* Designed for analytics at scale

Interview one-liner:

> Snowflake is a cloud-native data warehouse that separates compute and storage, enabling scalable, high-performance analytics with minimal operational overhead.

---

## 2. Why Snowflake over Traditional Databases?

Traditional databases tightly couple **compute and storage**, which limits scalability and concurrency.

Snowflake advantages:

* **Separation of compute and storage**
* Multiple teams can query the same data simultaneously
* Pay only for what you use (compute + storage)
* No index management or manual performance tuning

Interview angle:

> Snowflake solves concurrency and scaling issues common in traditional databases by decoupling compute from storage.

---

## 3. Snowflake Architecture (High-Level)

Snowflake has a **three-layer architecture**:

### 1. Storage Layer

* Centralized cloud storage
* Stores data in compressed, columnar format
* Automatically managed by Snowflake

### 2. Compute Layer

* Uses **Virtual Warehouses**
* Each warehouse is an independent compute cluster
* Provides workload isolation and concurrency

### 3. Cloud Services Layer

* Query optimization
* Metadata management
* Security, access control, authentication

Interview one-liner:

> Snowflake’s architecture consists of storage, compute, and cloud services layers, enabling scalability, concurrency, and simplified management.

---

## 4. Data Loading in Snowflake

Snowflake supports bulk and continuous data loading from cloud storage.

Common loading methods:

* `COPY INTO` for batch ingestion
* Snowpipe for continuous/auto ingestion

Key concepts:

* Uses **stages** as an intermediary layer
* Supports CSV, JSON, Parquet, Avro, ORC

Reference:

* `Data_Loading.sql`

---

## 5. TastyBytes Sample Dataset

TastyBytes is a sample dataset used to demonstrate real-world Snowflake workflows.

What it covers:

* POS (Point-of-Sale) data
* Customer and loyalty data
* Orders, menus, trucks, locations

Purpose:

* Practice data ingestion
* Schema design
* Analytics and reporting use cases

Reference:

* `TasteyBytes.sql`

---

## 6. Virtual Warehouses

A **Virtual Warehouse** is a Snowflake compute resource used to execute queries.

Key points:

* Handles **compute only**, not storage
* Multiple warehouses can query the same data
* No performance impact between warehouses

Important features:

* Auto-suspend and auto-resume
* Can scale up/down or out (multi-cluster)

Reference:

* `warehouse.sql`
* `Warehouse_Tastybytes.sql`

Interview one-liner:

> Virtual warehouses provide isolated compute resources in Snowflake, enabling high concurrency and flexible cost control.

---

## 7. Stages and Basic Ingestion

Stages are storage locations used for data loading and unloading.

Types of stages:

* Internal stages (Snowflake-managed)
* External stages (S3, Azure Blob, GCS)

Stage usage:

* Acts as a bridge between cloud storage and tables
* Used with `COPY INTO`

Stage references:

* Named stage → `@stage_name`
* Table stage → `@%table_name`
* User stage → `@~`

Reference files:

* `stages_1.sql`
* `stages_2.sql`
* `stages_Practice.sql`

---

## 8. Databases and Schemas

### Database

* Top-level logical container
* Organizes schemas and objects
* Used for isolation and access control

### Schema

* Logical grouping inside a database
* Contains tables, views, stages, functions
* Helps with organization and security

Interview focus:

> Databases provide isolation, while schemas organize objects and manage access within a database.

---

## 9. Tables in Snowflake

Tables store structured data in rows and columns.

Key characteristics:

* No indexes required
* Automatically optimized
* Supports Time Travel and cloning

Table types:

* Permanent (default)
* Transient (no Fail-safe)
* Temporary (session-based)

Interview one-liner:

> Snowflake tables are automatically optimized and do not require manual indexing or tuning.

---

## 10. Snowflake Table Data Types (Interview-Critical)

Snowflake supports flexible, cloud-native data types.

Categories:

* Numeric (NUMBER, INT, FLOAT)
* String (STRING, VARCHAR, TEXT)
* Date & Time (DATE, TIMESTAMP_NTZ, etc.)
* Boolean
* Semi-structured (VARIANT, ARRAY, OBJECT)

Key advantage:

* Semi-structured data can be queried directly without schema changes

Interview one-liner:

> Snowflake’s VARIANT data type allows seamless querying of semi-structured data alongside relational data.

---

## 11. Views in Snowflake

Views provide a logical abstraction over tables.

Why views are used:

* Simplify complex queries
* Enforce security
* Reuse business logic

Types of views:

* Standard views
* Secure views
* Materialized views

Important note:

* Views do **not** store data

Interview one-liner:

> Views simplify data access and improve security, while materialized views improve performance for heavy aggregations.

---

## 12. Semi-Structured Data in Snowflake (Interview-Critical)

Snowflake natively supports **semi-structured data**, allowing you to store and query data without enforcing a fixed schema at load time.

---

### What is Semi-Structured Data?
- Data that does not follow a strict row-column structure
- Common formats:
  - JSON
  - XML
  - Parquet
  - Avro

Snowflake can store this data **as-is** and query it using SQL.

---

### VARIANT Data Type
- Core data type for semi-structured data in Snowflake
- Can store:
  - JSON
  - XML
  - Arrays
  - Objects
- Uses **schema-on-read** (structure applied at query time)

Example:
```sql
SELECT order_details:payment.method
FROM sales_db.raw.orders;

Interview point:
VARIANT allows Snowflake to handle semi-structured data without predefined schemas.

---

### ARRAY Data Type
- Stores an **ordered list of values**
- Useful for repeated or multi-valued attributes

**Common use cases:**
- List of purchased items
- Multiple IDs per record

---

### OBJECT Data Type
- Stores **key–value pairs**
- Similar to a JSON object

**Common use cases:**
- Nested attributes
- Metadata storage

---

### Why This Matters (Interview Angle)
- No need to flatten JSON before loading
- Same SQL can query structured and semi-structured data
- Major advantage over traditional data warehouses

**Interview one-liner:**  
> Snowflake’s VARIANT, ARRAY, and OBJECT data types enable seamless analytics on semi-structured data using standard SQL.

---

## LATERAL FLATTEN (Interview-Critical)

`FLATTEN` is used to **explode semi-structured data** (ARRAY / OBJECT / VARIANT) into rows.

It is commonly used with **JSON data stored in VARIANT columns**.

---

### Why LATERAL FLATTEN?
- Converts nested arrays into relational rows
- Enables SQL analytics on JSON data
- Avoids preprocessing or ETL flattening outside Snowflake

---

### Basic Syntax
```sql
SELECT
    t.id,
    f.value
FROM my_table t,
LATERAL FLATTEN(input => t.json_column) f;
```

Snowflake Architecture (Interview-Critical)

Snowflake uses a Multi-Cluster Shared Data Architecture that separates compute, storage, and services.
This separation is Snowflake’s biggest differentiator from traditional data warehouses.

1. High-Level Architecture
+----------------------+
|   Cloud Services     |
+----------------------+
|   Compute Layer      |
| (Virtual Warehouses) |
+----------------------+
|   Storage Layer      |
+----------------------+
2. Storage Layer

What it does

Stores all data centrally

Uses cloud object storage (AWS S3 / Azure Blob / GCP Storage)

Data is automatically:

Compressed

Encrypted

Optimized (micro-partitions)

Key points

Storage is independent of compute

One copy of data is shared across all warehouses

No indexes needed

Interview line

Snowflake stores data in a centralized cloud storage layer that is fully managed, compressed, and encrypted.

3. Compute Layer (Virtual Warehouses)

What it does

Executes SQL queries

Loads data

Performs transformations

Key points

Compute is handled by Virtual Warehouses

Warehouses are:

Independent

Scalable

Isolated (no resource contention)

Multiple warehouses can query the same data simultaneously

Benefits

No performance impact between users

Easy workload isolation (ETL vs BI vs Ad-hoc)

Interview line

Snowflake uses virtual warehouses for compute, allowing independent scaling and workload isolation.

4. Cloud Services Layer

What it does

Authentication & access control

Query optimization

Metadata management

Transaction management

Result caching

Key components

Query parser & optimizer

Metadata store

Security & governance

SQL compilation

Interview line

The cloud services layer handles metadata, security, query optimization, and overall system management.

5. Multi-Cluster Shared Data Architecture

What it means

Multiple compute clusters

Shared centralized storage

No data duplication

Why it matters

High concurrency

High availability

Elastic scaling

Traditional vs Snowflake

Traditional DW	Snowflake
Compute tied to storage	Compute & storage separated
Scaling is hard	Scale instantly
Resource contention	Full isolation
6. How a Query Flows in Snowflake

User submits SQL

Cloud Services layer:

Authenticates

Optimizes query

Query sent to a Virtual Warehouse

Warehouse fetches data from Storage layer

Results returned to user

Results cached (if applicable)

7. Key Architecture Advantages

Zero infrastructure management

Pay-as-you-use

High concurrency

Automatic scaling

Strong support for semi-structured data

8. One-Line Interview Summary

Snowflake’s architecture separates storage, compute, and services, enabling independent scaling, high concurrency, and simplified cloud data warehousing.


