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
