WITH t1 AS (
	SELECT *,
		RANK() OVER (
			PARTITION BY fk_sales_order_item
			ORDER BY id_sales_order_item_status_history DESC
		) AS rank_status
	FROM ims_sales_order_item_status_history
),
t2 AS (
	SELECT fk_sales_order_item AS sales_order_item,
		fk_sales_order_item_status AS sales_order_item_status
	FROM t1
	WHERE t1.rank_status = 2
)
SELECT t3.fk_sales_order, t3.id_sales_order_item, t3.name, t3.sku, t2.sales_order_item_status
FROM t2
JOIN ims_sales_order_item AS t3
ON t2.sales_order_item = t3.id_sales_order_item;
