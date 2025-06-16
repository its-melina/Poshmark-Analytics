-- data cleaning queries --

-- 1. change dates to date datatype

ALTER table tops ALTER column sold_date TYPE date USING TO_DATE(sold_date, 'MM-DD-YYYY');


-- 2. change price data to integer datatype

UPDATE tops SET sold_price = REPLACE(REPLACE(sold_price, '$', ''), ',', '');
UPDATE tops SET original_price = REPLACE(REPLACE(original_price, '$', ''), ',', '');

ALTER table tops ALTER column sold_price TYPE integer USING sold_price::integer;
ALTER table tops ALTER column original_price TYPE integer USING original_price::integer;


-- 3. add column for % of original price a listing sold for

ALTER table tops 
	ADD column proportion_original_price FLOAT;

UPDATE tops
	SET proportion_original_price = ROUND(CAST(sold_price as NUMERIC)/original_price, 2);


-- 4. changing binary columns to integers for clarity

ALTER table tops ALTER column nwt TYPE integer USING nwt::integer;
ALTER table tops ALTER column boutique TYPE integer USING boutique::integer;


-- view table 

SELECT * from tops
	WHERE proportion_original_price is NOT NULL AND proportion_original_price < 1
	ORDER BY proportion_original_price DESC
	LIMIT 20;
