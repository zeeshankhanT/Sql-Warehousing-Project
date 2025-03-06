-- Create DDL for Tables:

IF OBJECT_ID('bronze.crm_cust_info' ,'U') IS NOT NULL
   DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(
cst_id	INT,
cst_key	NVARCHAR(50),
cst_firstname NVARCHAR(50),	
cst_lastname NVARCHAR(50),
cst_marital_status NVARCHAR(50),	
cst_gndr NVARCHAR(50),		
cst_create_date DATETIME
);
GO

IF OBJECT_ID('bronze.crm_prd_info' ,'U') IS NOT NULL
   DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
prd_id 	INT,
prd_key	NVARCHAR(50),
prd_nm	NVARCHAR(50),
prd_cost INT, 	
prd_line NVARCHAR(50),	
prd_start_dt DATETIME,	
prd_end_dt DATETIME
);
GO

IF OBJECT_ID('bronze.crm_sales_details' ,'U') IS NOT NULL
   DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
sls_ord_num	NVARCHAR(50),
sls_prd_key	NVARCHAR(50),
sls_cust_id	INT,
sls_order_dt INT,	
sls_ship_dt	INT,
sls_due_dt	INT,
sls_sales INT,	
sls_quantity INT,	
sls_price INT
);
GO

IF OBJECT_ID('bronze.erp_cust_aZ12' ,'U') IS NOT NULL
   DROP TABLE bronze.erp_cust_aZ12;
CREATE TABLE bronze.erp_cust_aZ12(
CID	NVARCHAR(50),
BDATE DATE,	
GEN NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_loc_a101' ,'U') IS NOT NULL
   DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
CID	NVARCHAR(50),
CNTRY NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2' ,'U') IS NOT NULL
   DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2(
ID	NVARCHAR(50),
CAT	NVARCHAR(50),
SUBCAT NVARCHAR(50),	
MAINTENANCE NVARCHAR(50)
);
GO

-- Develop sql load scripts with stored procedure
	
CREATE OR ALTER PROCEDURE bronze.load_bronze as 
BEGIN
	PRINT '=============================================================='
	PRINT 'lOADING BRONZE LAYER'
	PRINT '=============================================================='

	PRINT '--------------------------------------------------------------'
	PRINT 'LOADING CRM TABLES'
	PRINT '--------------------------------------------------------------'

	PRINT '>> TRUNCATING TABLE bronze.crm_cust_info'
	TRUNCATE TABLE bronze.crm_cust_info;

	PRINT '>> INSERTING DATA INTO TABLE bronze.crm_cust_info'
	BULK INSERT bronze.crm_cust_info
	FROM 'D:\ALL REPORTS\1. Zeeshan\1. Youtube\sql Warehousing\Sql-Warehousing-Project\datasets\source_crm\cust_info.csv'
	WITH (
	 FIRSTROW = 2,
	 FIELDTERMINATOR = ',',
	 TABLOCK --LOCKS THE TABLE WHILE LOADING IT
	);

	SELECT * FROM bronze.crm_cust_info;
	SELECT count(*) FROM bronze.crm_cust_info;

	PRINT '>> TRUNCATING TABLE bronze.crm_prd_info'
	TRUNCATE TABLE bronze.crm_prd_info;

	PRINT '>> INSERTING DATA INTO TABLE bronze.crm_prd_info'
	BULK INSERT bronze.crm_prd_info
	FROM 'D:\ALL REPORTS\1. Zeeshan\1. Youtube\sql Warehousing\Sql-Warehousing-Project\datasets\source_crm\prd_info.csv'
	WITH (
	 FIRSTROW = 2,
	 FIELDTERMINATOR = ',',
	 TABLOCK --LOCKS THE TABLE WHILE LOADING IT
	);

	SELECT * FROM bronze.crm_prd_info;
	SELECT count(*) FROM bronze.crm_prd_info;

	PRINT '>> TRUNCATING TABLE bronze.crm_sales_details'
	TRUNCATE TABLE bronze.crm_sales_details;
	
	PRINT '>> INSERTING DATA INTO TABLE bronze.crm_sales_details'
	BULK INSERT bronze.crm_sales_details
	FROM 'D:\ALL REPORTS\1. Zeeshan\1. Youtube\sql Warehousing\Sql-Warehousing-Project\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	)

	SELECT COUNT(*) FROM bronze.crm_sales_details;
	
	PRINT '--------------------------------------------------------------'
	PRINT 'LOADING ERP TABLES'
	PRINT '--------------------------------------------------------------'

	PRINT '>> TRUNCATING TABLE bronze.erp_cust_aZ12'
	TRUNCATE TABLE bronze.erp_cust_aZ12;

	PRINT '>> INSERTING DATA INTO TABLE bronze.erp_cust_aZ12'
	BULK INSERT bronze.erp_cust_aZ12
	FROM 'D:\ALL REPORTS\1. Zeeshan\1. Youtube\sql Warehousing\Sql-Warehousing-Project\datasets\source_erp\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	)

	SELECT COUNT(*) FROM bronze.erp_cust_aZ12;
	
	PRINT '>> TRUNCATING TABLE bronze.erp_loc_a101'
	TRUNCATE TABLE bronze.erp_loc_a101;
	PRINT '>> INSERTING DATA INTO TABLE bronze.erp_loc_a101'
	BULK INSERT bronze.erp_loc_a101
	FROM 'D:\ALL REPORTS\1. Zeeshan\1. Youtube\sql Warehousing\Sql-Warehousing-Project\datasets\source_erp\LOC_A101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	)

	SELECT COUNT(*) FROM bronze.erp_loc_a101;

	PRINT '>> TRUNCATING TABLE bronze.erp_px_cat_g1v2'
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	PRINT '>> INSERTING DATA INTO TABLE bronze.erp_px_cat_g1v2'
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'D:\ALL REPORTS\1. Zeeshan\1. Youtube\sql Warehousing\Sql-Warehousing-Project\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	)

	SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;

END
_______________________________________________________
EXECUTE bronze.load_bronze;
