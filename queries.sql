-- Query 1: Average Property Price by State
SELECT state, 
       COUNT(*) as total_listings,
       ROUND(AVG(price), 0) as avg_price,
       ROUND(MIN(price), 0) as min_price,
       ROUND(MAX(price), 0) as max_price
FROM real_estate_db.properties
WHERE price > 0 AND price < 3000000
GROUP BY state
ORDER BY avg_price DESC;

-- Query 2: Top 10 Cities by Total Listings
SELECT city, state,
       COUNT(*) as total_listings,
       ROUND(AVG(price), 0) as avg_price
FROM real_estate_db.properties
WHERE price > 0
GROUP BY city, state
ORDER BY total_listings DESC
LIMIT 10;

-- Query 3: Average Price by Bedroom Count
SELECT CAST(bed AS INT) as bedrooms,
       COUNT(*) as total,
       ROUND(AVG(price), 0) as avg_price
FROM real_estate_db.properties
WHERE price > 0 AND bed > 0 AND bed <= 10
GROUP BY CAST(bed AS INT)
ORDER BY bedrooms;
