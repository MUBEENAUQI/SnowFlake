# Snowflake – Interview Notes (Module 1)

These notes are **interview-focused and concept-driven**.  
All SQL implementations are intentionally kept in separate `.sql` files.  
This document explains **what Snowflake is, how it works, and how to confidently explain it in interviews**.

---

## 1. What is Snowflake?

Snowflake is a **cloud-native data platform** designed for data warehousing, analytics, and secure data sharing.

### Key Characteristics
- Built **only for the cloud** (AWS, Azure, GCP)
- Fully managed (no servers, tuning, or maintenance)
- Designed for large-scale analytics
- Supports structured and semi-structured data

### Interview One-Liner
> Snowflake is a cloud-native data warehouse that separates compute and storage, enabling scalable, high-performance analytics with minimal operational overhead.

---

## 2. Why Snowflake Over Traditional Databases?

Traditional databases tightly couple **compute and storage**, which leads to scalability and concurrency limitations.

### Snowflake Advantages
- **Decoupled compute and storage**
- Multiple users and workloads can run concurrently
- Pay only for what you use
- No index management or manual tuning

### Interview Angle
> Snowflake solves scalability and concurrency issues by decoupling compute from storage.

---

## 3. Snowflake Architecture (High-Level)

Snowflake follows a **Multi-Cluster Shared Data Architecture** with three independent layers.

---

### 3.1 Storage Layer
Responsible for storing all data.

**Key Points**
- Uses cloud object storage (S3, Azure Blob, GCS)
- Data is automatically:
  - Compressed
  - Encrypted
  - Organized into micro-partitions
- Fully managed by Snowflake

**Interview Line**
> Snowflake stores data in a centralized, cloud-managed storage layer optimized automatically.

---

### 3.2 Compute Layer (Virtual Warehouses)
Responsible for query execution and data processing.

**Virtual Warehouses**
- Independent compute clusters
- Used for:
  - Query execution
  - Data loading
  - Transformations

**Key Characteristics**
- Isolated and independent
- Instantly scalable (up/down or out)
- Multiple warehouses can access the same data
- No resource contention

**Interview Line**
> Snowflake uses virtual warehouses for compute, enabling workload isolation and independent scaling.

---

### 3.3 Cloud Services Layer
Acts as the brain of Snowflake.

**Responsibilities**
- Authentication and access control
- Query parsing and optimization
- Metadata management
- Transaction management
- Result caching

**Interview Line**
> The cloud services layer handles metadata, security, query optimization, and system coordination.

---

### 3.4 Query Execution Flow
1. User submits a SQL query
2. Cloud Services authenticates and optimizes the query
3. A virtual warehouse executes the query
4. Data is fetched from the storage layer
5. Results are returned (and may be cached)

---

### 3.5 Architecture Advantages
- Zero infrastructure management
- High concurrency
- Independent scaling
- Pay-as-you-go pricing
- Native support for semi-structured data

**Architecture Interview One-Liner**
> Snowflake’s architecture separates storage, compute, and services, enabling scalable, high-performance cloud data warehousing.

---

## 4. Data Loading in Snowflake

Snowflake supports both batch and continuous data ingestion.

### Common Methods
- `COPY INTO` – batch loading
- Snowpipe – continuous/auto ingestion

### Key Concepts
- Uses **stages** as an intermediary
- Supports CSV, JSON, Parquet, Avro, ORC

**Reference**
- `Data_Loading.sql`

---

## 5. TastyBytes Sample Dataset

TastyBytes is a realistic sample dataset used for hands-on learning.

### Covers
- POS (Point-of-Sale) data
- Menus, orders, trucks, locations
- Customer and franchise data

### Purpose
- Practice ingestion
- Schema design
- Analytics use cases

**Reference**
- `TasteyBytes.sql`

---

## 6. Virtual Warehouses

A **Virtual Warehouse** is Snowflake’s compute engine.

### Key Points
- Handles compute only
- Multiple warehouses can query the same data
- No performance impact between warehouses

### Features
- Auto-suspend and auto-resume
- Scaling up/down and multi-cluster scaling

**Interview One-Liner**
> Virtual warehouses provide isolated compute resources, enabling high concurrency and cost control.

---

## 7. Stages and Basic Ingestion

Stages are storage locations used to load and unload data.

### Types of Stages
- Internal stages (Snowflake-managed)
- External stages (S3, Azure Blob, GCS)

### Stage References
- Named stage → `@stage_name`
- Table stage → `@%table_name`
- User stage → `@~`

**Reference Files**
- `stages_1.sql`
- `stages_2.sql`
- `stages_Practice.sql`

---

## 8. Databases and Schemas

### Database
- Top-level logical container
- Provides isolation and access control
- Contains schemas

### Schema
- Logical grouping inside a database
- Contains tables, views, stages, functions

**Interview Focus**
> Databases provide isolation, while schemas organize objects and manage access.

---

## 9. Tables in Snowflake

Tables store structured data in rows and columns.

### Key Characteristics
- No indexes required
- Automatically optimized
- Supports Time Travel and cloning

### Table Types
- Permanent
- Transient (no Fail-safe)
- Temporary (session-based)

**Interview One-Liner**
> Snowflake tables are automatically optimized and do not require manual indexing.

---

## 10. Snowflake Table Data Types (Interview-Critical)

Snowflake supports flexible, cloud-native data types.

### Categories
- Numeric: NUMBER, INT, FLOAT
- String: STRING, VARCHAR, TEXT
- Date & Time: DATE, TIMESTAMP_NTZ, TIMESTAMP_LTZ, TIMESTAMP_TZ
- Boolean
- Semi-structured: VARIANT, ARRAY, OBJECT

**Key Advantage**
- Semi-structured data can be queried directly without schema changes

**Interview One-Liner**
> Snowflake’s VARIANT data type enables seamless querying of semi-structured data alongside relational data.

---

## 11. Views in Snowflake

Views provide a logical abstraction over tables.

### Why Use Views
- Simplify complex queries
- Enforce security
- Reuse business logic

### Types of Views
- Standard views
- Secure views
- Materialized views

**Important**
- Views do **not** store data

**Interview One-Liner**
> Views simplify data access, while materialized views improve performance for heavy aggregations.

---

## 12. Semi-Structured Data in Snowflake (Interview-Critical)

Snowflake natively supports semi-structured data using **schema-on-read**.

### Supported Formats
- JSON
- XML
- Parquet
- Avro

---

### VARIANT Data Type
- Core type for semi-structured data
- Stores JSON, XML, ARRAY, OBJECT
- Structure applied at query time

**Interview Point**
> VARIANT allows Snowflake to query semi-structured data without predefined schemas.

---

### ARRAY Data Type
- Ordered list of values
- Used for repeated or multi-valued attributes

**Use Cases**
- List of purchased items
- Multiple IDs per record

---

### OBJECT Data Type
- Key–value pairs
- Similar to JSON objects

**Use Cases**
- Nested attributes
- Metadata storage

---

### Why This Matters (Interview Angle)
- No need to flatten JSON before loading
- Same SQL for structured and semi-structured data
- Major advantage over traditional warehouses

**Interview One-Liner**
> Snowflake’s VARIANT, ARRAY, and OBJECT types enable analytics on semi-structured data using standard SQL.

---

## 13. LATERAL FLATTEN (Interview-Critical)

`FLATTEN` converts semi-structured data into relational rows.

### Why LATERAL FLATTEN?
- Explodes arrays into rows
- Enables analytics on JSON data
- Avoids external ETL preprocessing

**Interview One-Liner**
> LATERAL FLATTEN allows Snowflake to transform nested JSON into relational rows using SQL.

---

## Module 1 Summary

By completing Module 1:
- Core Snowflake architecture is understood
- Data loading and ingestion concepts are clear
- Compute, storage, and concurrency concepts are interview-ready
- Semi-structured data handling is a strong skill area

➡️ **Module 2 will focus on performance, optimization, security, and advanced features.**
![alt text](image.png)