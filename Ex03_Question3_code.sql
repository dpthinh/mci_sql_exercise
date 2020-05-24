SELECT *
FROM (
	SELECT shipping_type, SUM(unit_price) AS total_unit_price
	FROM ims_sales_order_item
	GROUP BY shipping_type
) AS t
WHERE t.shipping_type = 'cross_docking';