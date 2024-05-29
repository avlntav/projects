WITH RankedRedemptions AS (
  SELECT
    *,
    DENSE_RANK() OVER (PARTITION BY a.redemptionDate ORDER BY a.createDateTime DESC) AS rnk
  FROM `project-x-420516.raw_dataset.tblRedemptions-ByDay` AS a
  LEFT JOIN `project-x-420516.raw_dataset.tblRetailers` AS b ON a.retailerId = b.id
  WHERE b.retailerName = "ABC Store"
    AND a.redemptionDate BETWEEN '2023-10-30' AND '2023-11-05'
)
SELECT redemptionDate,redemptionCount
FROM RankedRedemptions
WHERE rnk = 1
ORDER BY redemptionDate;

/* 
Question 1) 2023-11-05 has the least number of redemptions and the count is 3702
Question 2) 2023-11-04 has the highest number of redemptions and the count is 5224
Question 3) 2023-11-06 11:00:00 UTC is the createdDateTime for each redemption. 
Question 4) instead of using CTE the above query can be written using sub-query. 
*/ 