-- 4. Check for Duplicates
-- Identify and examine duplicate entries based on 'Transaction_ID'
SELECT *
FROM (
  SELECT Transaction_Id,
         ROW_NUMBER() OVER(PARTITION BY Transaction_ID ORDER BY Transaction_ID) AS row_num
  FROM dirty_cafe_sales
) AS duplicates
WHERE row_num > 1;

-- No duplicates found 
