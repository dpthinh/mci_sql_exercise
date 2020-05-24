
SELECT id_sales_order_item,unit_price,sku
FROM ims_sales_order_item
WHERE id_sales_order_item IN (
	SELECT t2.fk_sales_order_item
	FROM ims_sales_order_item_status AS t1
	JOIN ims_sales_order_item_status_history AS t2
	ON t1.id_sales_order_item_status = t2.fk_sales_order_item_status
	WHERE t1.status = 'picklisted' 
		AND CONVERT(VARCHAR(10), t2.created_at, 101) = '11/06/2013'
)
