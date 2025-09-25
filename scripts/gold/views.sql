-- Creating dimension views for customers 


create view gold.dim_customers as
select 
ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
ci.cst_id as Customer_id,
ci.cst_key as Customer_number,
ci.cst_firstname as First_name,
ci.cst_lastname as Last_name,
la.cntry as country,
ci.cst_marital_status as marital_status,
ca.bdate   AS birthdate,
 ci.cst_create_date    AS create_date,
case
when ci.cst_gndr != 'n/a' then ci.cst_gndr
else coalesce(ca.gen, 'n/a') end as Gender
from silver.crm_cust_info ci
left join  silver.erp_cust_az12 ca
on ci.cst_key= ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key = la.cid;


-- Creating dimension views for products 

create view gold.dim_products as
select
ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key, 
 pn.prd_id    AS product_id,
 pn.prd_key   AS product_number,
 pn.prd_nm    AS product_name,
 pn.cat_id     AS category_id,
 pc.cat        AS category,
 pc.subcat      AS subcategory,
 pc.maintenance  AS maintenance,
 pn.prd_cost     AS cost,
 pn.prd_line     AS product_line,
 pn.prd_start_dt AS start_date
from silver.crm_prd_info pn 
left join silver.erp_px_cat_g1v2 pc on 
pn.cat_id= pc.id
where pn.prd_end_dt is null;


-- Creating facts table

CREATE VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_key AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt  AS shipping_date,
    sd.sls_due_dt   AS due_date,
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id;



