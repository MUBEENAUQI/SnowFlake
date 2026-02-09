CREATE WAREHOUSE MubeenaWarehouse; --> to create a warehouse

SHOW WAREHOUSES; --> to show all warehouses

USE WAREHOUSE COMPUTE_WH; --> to switch warehouse

---> switching warehouses
USE WAREHOUSE COMPUTE_WH;
USE WAREHOUSE MUBEENAWAREHOUSE;
--> Vertical Scaling warehouses
ALTER WAREHOUSE MUBEENAWAREHOUSE SET WAREHOUSE_SIZE=MEDIUM;
ALTER WAREHOUSE MUBEENAWAREHOUSE SET WAREHOUSE_SIZE=SMALL;

--> To delete a warehouse
DROP WAREHOUSE MUBEENAWAREHOUSE;
USE WAREHOUSE cluster_warehouse;
--> Multicluster warehouses --> horizontal scaling
CREATE WAREHOUSE cluster_warehouse 
WITH
    WAREHOUSE_SIZE = 'MEDIUM'
    WAREHOUSE_TYPE = 'STANDARD'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    MIN_CLUSTER_COUNT = 1
    MAX_CLUSTER_COUNT = 3
    SCALING_POLICY = 'STANDARD';

--> AUTO_SUSPEND helps control cost by automatically stopping compute resources when they are idle.
--> AUTO_RESUME ensures warehouses restart automatically when needed, enabling seamless query execution without manual intervention.
-->The STANDARD scaling policy prioritizes performance by quickly adding clusters to reduce query queuing during high concurrency.

ALTER WAREHOUSE cluster_warehouse 
SET 
AUTO_RESUME = FALSE
AUTO_SUSPEND = 15;

--> to suspend a warehouse to save credits
ALTER WAREHOUSE cluster_warehouse SUSPEND;
DROP WAREHOUSE cluster_warehouse;

--> checking for is_current feature
CREATE WAREHOUSE TEST1 WITH WAREHOUSE_SIZE='SMALL' ;
CREATE WAREHOUSE TEST2;
SHOW WAREHOUSES;
USE WAREHOUSE TEST1;
DROP WAREHOUSE TEST1;
DROP WAREHOUSE TEST2;
