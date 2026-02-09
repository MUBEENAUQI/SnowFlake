# Tasty Bytes Snowflake Build – Detailed Explanation

This document explains the Snowflake SQL script used to build the **Tasty Bytes** data platform end to end.  
It covers security setup, data architecture, ingestion, transformation, and analytics layers.

---

## 1. Role Setup (Security Context)

```sql
USE ROLE accountadmin;

Explanation

Switches to the ACCOUNTADMIN role

Grants full permissions to create databases, schemas, warehouses, stages, tables, and views

Snowflake uses role-based access control (RBAC)

Interview takeaway:
Objects in Snowflake are created under the active role, not the user.

2. Database, Schema, and Warehouse Creation
Database Creation
CREATE OR REPLACE DATABASE tasty_bytes;


Creates the main database

OR REPLACE drops and recreates the database if it exists

Common in demos or controlled builds (not production)

Schema Creation (Layered Architecture)
CREATE OR REPLACE SCHEMA tasty_bytes.raw_pos;
CREATE OR REPLACE SCHEMA tasty_bytes.raw_customer;
CREATE OR REPLACE SCHEMA tasty_bytes.harmonized;
CREATE OR REPLACE SCHEMA tasty_bytes.analytics;

Purpose of Each Schema
Schema	Purpose
raw_pos	Raw point-of-sale data
raw_customer	Raw customer data
harmonized	Joined and business-ready data
analytics	Analyst-friendly views

Interview takeaway:
Layered schemas help separate raw ingestion, business logic, and analytics consumption.

Warehouse Creation (Compute Layer)
CREATE OR REPLACE WAREHOUSE demo_build_wh
    WAREHOUSE_SIZE = 'xlarge'
    WAREHOUSE_TYPE = 'standard'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE;

Explanation

XL warehouse for fast ingestion

Auto-suspends after 60 seconds of inactivity to save cost

Auto-resumes when queries are submitted

Used temporarily for data loading

3. File Format and Stage Creation
File Format
CREATE OR REPLACE FILE FORMAT tasty_bytes.public.csv_ff 
TYPE = 'csv';


Defines how CSV files are parsed

Reusable across multiple data loads

Stage Creation
CREATE OR REPLACE STAGE tasty_bytes.public.s3load
URL = 's3://sfquickstarts/tasty-bytes-builder-education/'
FILE_FORMAT = tasty_bytes.public.csv_ff;

Explanation

A stage is a pointer to external cloud storage (S3)

Snowflake does not store data in the stage

Used with COPY INTO for ingestion

Interview takeaway:
Stages act as an intermediary layer between Snowflake and cloud storage.

4. Raw Zone Table Creation (Ingestion Layer)

Raw tables closely mirror source data with minimal transformation.

Key Characteristics

Mostly VARCHAR and NUMBER types

No business logic

One VARIANT column for semi-structured data

Example: Menu Table
menu_item_health_metrics_obj VARIANT


Stores JSON / semi-structured data

Snowflake can query it natively

Interview takeaway:
Snowflake supports semi-structured data using the VARIANT data type.

Raw POS Tables

country

franchise

location

menu

truck

order_header

order_detail

Raw Customer Table

customer_loyalty (stored separately for domain separation)

5. Harmonized Views (Business Logic Layer)
Orders View
CREATE OR REPLACE VIEW tasty_bytes.harmonized.orders_v AS ...

What it does

Joins orders, order details, trucks, menu, franchise, location, and customer data

Uses LEFT JOIN for optional customer loyalty data

Creates a single, business-ready dataset

Interview takeaway:
Harmonized views centralize business logic and avoid repetitive joins.

Customer Loyalty Metrics View
SUM(oh.order_total) AS total_sales
ARRAY_AGG(DISTINCT oh.location_id)

What it calculates

Total sales per customer

List of locations visited by each customer

Why ARRAY_AGG

Preserves multi-valued relationships

Avoids data loss

6. Analytics Views (Consumption Layer)
Orders Analytics View
CREATE OR REPLACE VIEW tasty_bytes.analytics.orders_v AS
SELECT DATE(o.order_ts) AS date, * 
FROM tasty_bytes.harmonized.orders_v o;

Purpose

Simplifies data for reporting

Adds derived columns

Optimized for BI tools

Customer Loyalty Metrics Analytics View
CREATE OR REPLACE VIEW tasty_bytes.analytics.customer_loyalty_metrics_v AS
SELECT * FROM tasty_bytes.harmonized.customer_loyalty_metrics_v;


Interview takeaway:
Analytics views are designed for consumption by analysts and dashboards.

7. Data Loading (Bulk Ingestion)
Activate Warehouse
USE WAREHOUSE demo_build_wh;

COPY INTO Commands
COPY INTO tasty_bytes.raw_pos.menu
FROM @tasty_bytes.public.s3load/raw_pos/menu/;

What happens

Snowflake reads files from S3

Applies CSV file format

Loads data in parallel

Tracks loaded files automatically

Interview takeaway:
COPY INTO is Snowflake’s scalable bulk ingestion command.

8. Cleanup (Cost Optimization)
DROP WAREHOUSE demo_build_wh;


Warehouse is no longer needed

Stops compute billing completely

Interview takeaway:
Temporary warehouses should be dropped to avoid unnecessary costs.

End-to-End Architecture Flow
S3
 ↓
STAGE
 ↓
RAW TABLES
 ↓
HARMONIZED VIEWS
 ↓
ANALYTICS VIEWS
 ↓
BI / REPORTING