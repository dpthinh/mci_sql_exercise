DECLARE @shipping_type VARCHAR(MAX);

SET @shipping_type = 'marketplace';

WITH t1 AS (
	SELECT id_sales_order_item,unit_price,shipping_type
	FROM ims_sales_order_item
	WHERE id_sales_order_item IN (
		SELECT t2.fk_sales_order_item
		FROM ims_sales_order_item_status AS t1
		JOIN ims_sales_order_item_status_history AS t2
		ON t1.id_sales_order_item_status = t2.fk_sales_order_item_status
		WHERE t1.status = 'picklisted' 
			AND CONVERT(VARCHAR(10), t2.created_at, 101) = '11/06/2013'
	)
)
,
t2 AS (
	SELECT shipping_type, COUNT(t1.id_sales_order_item) AS num_items
	FROM t1
	WHERE unit_price BETWEEN 50 AND 100
	GROUP BY (shipping_type)
)

SELECT t3.shipping_type,
	CASE
		WHEN t2.num_items IS NULL THEN 0
		ELSE t2.num_items
	END AS total_items
FROM (
	SELECT shipping_type
	FROM ims_sales_order_item
	GROUP BY shipping_type
) AS t3
LEFT JOIN t2
ON t3.shipping_type = t2.shipping_type