-- Sales and Pricing Insights --

-- 1. the top performing brands in women's tops by volume of sales

SELECT brand, COUNT(brand) as "count" FROM tops
	GROUP BY brand
	ORDER BY "count" DESC;

-- 1b. the top performing brands in women's tops by volume of sales for non-boutique items

SELECT brand, COUNT(brand) as "count" FROM tops
	WHERE "boutique" = 0
	GROUP BY brand
	ORDER BY "count" DESC;

-- 2. average sold price per brand

SELECT brand, ROUND(AVG(sold_price), 2) as "average price" FROM tops
	GROUP BY brand
	ORDER BY "average price" DESC;

-- 2. average sold price per brand for the top 10 performing brands only

CREATE VIEW top_10_performing_brands_by_sales AS 
SELECT brand, ROUND(AVG(sold_price), 2) as "average price", COUNT(brand) as "count" FROM tops
	GROUP BY brand
	ORDER BY "count" DESC
	LIMIT 10;

-- ordered by average price

SELECT * FROM top_10_performing_brands_by_sales
	ORDER BY "average price" DESC;

