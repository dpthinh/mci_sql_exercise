SELECT t1.id_sales_order_item, t1.name, t1.sku, t1.fk_sales_order_item_status
FROM ims_sales_order_item AS t1
JOIN ims_sales_order_item_status AS t2
ON t1.fk_sales_order_item_status = t2.id_sales_order_item_status
WHERE t1.shipping_type = 'warehouse' AND t2.status = 'delivered';