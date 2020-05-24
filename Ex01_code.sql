SELECT t3.[Category initial], 
		COUNT(t3.EventName) AS 'Number of Events', 
		CAST(AVG(CAST(t3.[Length of EventName] AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS 'Average event name length'
FROM (
	SELECT t1.EventName, LEN(t1.EventName) AS 'Length of EventName', SUBSTRING(t2.CategoryName,1,1) AS 'Category initial'
	FROM tblEvent AS t1
	JOIN tblCategory AS t2
	ON t1.CategoryID = t2.CategoryID
) AS t3
GROUP BY t3.[Category initial]