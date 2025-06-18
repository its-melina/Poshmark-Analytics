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
	
-- 2b. average sold price per brand for the top 10 performing brands only, non boutique listings

CREATE VIEW top_10_performing_brands_by_sales_non_boutique AS 
SELECT brand, ROUND(AVG(sold_price), 2) as "average price", COUNT(brand) as "count" FROM tops
	WHERE boutique = 0
	GROUP BY brand
	ORDER BY "count" DESC
	LIMIT 10;

-- ordered by average price

SELECT * FROM top_10_performing_brands_by_sales
	ORDER BY "average price" DESC;

SELECT * FROM top_10_performing_brands_by_sales_non_boutique
	ORDER BY "average price" DESC;

-- 3. brands with the least days to sell on average

CREATE VIEW brands_avg_days_to_sell AS
SELECT brand, ROUND(AVG(sold_date - post_date), 1) as "avg days to sell", COUNT(brand) as "count"
	FROM tops
	WHERE boutique = 0
	GROUP BY brand;

SELECT * FROM brands_avg_days_to_sell
	WHERE "count" > 50
	ORDER BY "avg days to sell" ASC;

-- 4. brands with highest proportion of original price

SELECT brand, ROUND(AVG(CAST(proportion_original_price as numeric)), 2) AS "average proportion", ROUND(AVG(sold_price), 2) AS "average price" FROM tops
	WHERE proportion_original_price IS NOT NULL AND proportion_original_price <= 1
	GROUP BY brand
	ORDER BY "average proportion" DESC;

-- 5. average prices for types of tops

CREATE TEMPORARY TABLE categories AS
SELECT name,
	(LOWER(name) LIKE '%blouse%') as blouse,
	(LOWER(name) LIKE '%tank%') as tank,
	(LOWER(name) LIKE '%crop%') as crop
FROM tops

SELECT * FROM categories
	WHERE tank is True


