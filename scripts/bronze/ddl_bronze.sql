/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
Go

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);

BULK INSERT bronze.crm_cust_info
from 'C:\Users\GOUTHAM\Documents\datasets\source_crm\cust_info.csv'
WITH (
 FIRSTROW = 2,
 FIELDTERMINATOR = ',',
 TABLOCK
);

select *from bronze.crm_cust_info;

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

BULK INSERT bronze.crm_prd_info
from 'C:\Users\GOUTHAM\Documents\datasets\source_crm\prd_info.csv'
WITH (
 FIRSTROW = 2,
 FIELDTERMINATOR = ',',
 TABLOCK
);

select * from bronze.crm_prd_info;

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);

BULK INSERT bronze.crm_sales_details
from 'C:\Users\GOUTHAM\Documents\datasets\source_crm\sales_details.csv'
WITH (
 FIRSTROW = 2,
 FIELDTERMINATOR = ',',
 TABLOCK
);

select * from bronze.crm_sales_details;

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);

BULK INSERT bronze.erp_cust_az12
from 'C:\Users\GOUTHAM\Documents\datasets\source_erp\CUST_AZ12.csv'
WITH (
 FIRSTROW = 2,
 FIELDTERMINATOR = ',',
 TABLOCK
);

select * from bronze.erp_cust_az12;

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);

BULK INSERT bronze.erp_loc_a101
from 'C:\Users\GOUTHAM\Documents\datasets\source_erp\LOC_A101.csv'
WITH (
 FIRSTROW = 2,
 FIELDTERMINATOR = ',',
 TABLOCK
);
select * from bronze.erp_loc_a101;

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);

BULK INSERT bronze.erp_px_cat_g1v2
from 'C:\Users\GOUTHAM\Documents\datasets\source_erp\PX_CAT_G1V2.csv'
WITH (
 FIRSTROW = 2,
 FIELDTERMINATOR = ',',
 TABLOCK
);

select * from bronze.erp_px_cat_g1v2;
