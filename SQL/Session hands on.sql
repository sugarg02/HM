#show to code SELECT clause - column specifications, Aliase, concat, functions, duplicates
select * from vendor_contacts;
# Select id, account number, item amount
select invoice_id, account_number, line_item_amount from invoice_line_items;
# Write a query to retrive 3 columns sorted in descending order by invoice total for the invoices table
select invoice_id, vendor_id,invoice_total from invoices order by invoice_total desc;
# write a query to display the outstanding payemnt 
select invoice_id, vendor_id, (payment_total - credit_total) as outstandingamt from invoices;
# to display the vendors id and full name and order by last name and then by fisrt name 
SELECT 
    vendor_id, CONCAT(first_name, ' ', last_name)
FROM
    vendor_contacts
ORDER BY last_name , first_name;
# return the vendor id whose lastname beging with Letter A  wildcards
# *a zero or more occurance ?single char h?t   %  __   h[oai]t  hit  ^ h[^oa]t
# hot hat hit hut 
#like % __
#like 'a%t'  like '%a'   like '__r%'  like '__r__'   
SELECT 
    vendor_id, CONCAT(first_name, ' ', last_name)
FROM
    vendor_contacts
WHERE
    last_name LIKE 'a%'
ORDER BY last_name , first_name;
# vendor names from a to p
# where first_name > 'Q' 
/*Due Date , Invoice total  100, 10% of the value of invoice_total  10 , Plus 10% the value of Invoice_total 110  
Return only the row with an invoice total that's greater than or equal to 500 and 
less than or equal to 1000. Sort the result set in dec invoice_due _date
*/
SELECT invoice_due_date AS "Due Date", 
       invoice_total AS "Invoice Total", 
       invoice_total / 10 AS "10%",
       invoice_total * 1.1 AS "Plus 10%"
FROM invoices
WHERE invoice_total >= 500 AND invoice_total <= 1000
ORDER BY invoice_due_date DESC;


/*
invoices table 
invoice_number, invoice_date, balance_due, payment_date
Return only the row where the payment_date column contains a null value.
Hint: invoice_total- payment_total - credit_total = balance due
payment_date*/
SELECT invoice_number, 
       invoice_date, 
       invoice_total - payment_total - credit_total AS balance_due,
       payment_date
FROM invoices
WHERE payment_date IS NOT NULL;

## SUBQUERY - NESTED QUERY 
/* Four ways to introduce a subquery in a SELECT statement
1. In a WHERE clause as a search condition 
2. In a HAVING clause as a search condition 
3. In the FROM clause as a table specification 
4. In the SELECT clause as column specification
*/

SELECT invoice_number, invoice_date, invoice_total FROM invoices WHERE  invoice_total >
(select avg(credit_total) from invoices) 
order by invoice_date;

select invoice_number, invoice_date, invoice_total from invoices 
where vendor_id IN 
(select vendor_id from vendors where vendor_state = 'CA')
ORDER BY invoice_date;

select vendor_name, 
(select max(invoice_date) from invoices
where vendor_id = vendors.vendor_id) AS latest_inv
from vendors 
order BY latest_inv DESC;

select vendor_state, MAX(sum_of_invoices) AS max_sum_of_invoices
from 
   (select vendor_state, vendor_name, sum(invoice_total) AS sum_of_invoices
   FROM vendors v JOIN invoices i
   on v.vendor_id = i.vendor_id
   GROUP BY vendor_state, vendor_name) t
GROUP by vendor_stategeneral_ledger_accounts; 

#views
create view vendordetailsvendordetails as
SELECT * FROM vendors where vendor_state = 'DC';

select * from vendordetails;


