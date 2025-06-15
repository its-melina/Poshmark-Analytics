-- data cleaning queries --

ALTER table tops ALTER column sold_date TYPE date USING TO_DATE(sold_date, 'MM-DD-YYYY');

SELECT * from tops
LIMIT 10;




