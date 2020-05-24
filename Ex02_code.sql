DECLARE @first_word_each_EpisodeType VARCHAR(MAX);
SET @first_word_each_EpisodeType = '';

SELECT @first_word_each_EpisodeType += 
	CASE
		WHEN @first_word_each_EpisodeType = '' THEN '' ELSE ','
	END + QUOTENAME(SUBSTRING(EpisodeType,1,CHARINDEX(' ',EpisodeType)-1))
FROM tblEpisode
GROUP BY EpisodeType;

DECLARE @sql VARCHAR(MAX) = '
SELECT * FROM (
	SELECT t1.DoctorId, t1.DoctorName,  SUBSTRING(t2.EpisodeType,1,CHARINDEX('' '',t2.EpisodeType)-1) AS first_word_of_EpisodeType
	FROM tblDoctor AS t1
	INNER JOIN tblEpisode AS t2
	ON t1.DoctorId = t2.DoctorId
) AS t3
PIVOT (
	COUNT(DoctorId)
	FOR first_word_of_EpisodeType IN (' + @first_word_each_EpisodeType + ')
) AS pivot_table;
'
EXEC(@sql)

