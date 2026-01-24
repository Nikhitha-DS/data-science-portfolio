-- Revenue Leakage Detection Queries

-- 1. Invoices where final amount does not match total payments
SELECT 
    i.invoice_id,
    i.final_amount,
    SUM(p.paid_amount) AS total_paid
FROM invoices i
LEFT JOIN payments p 
    ON i.invoice_id = p.invoice_id
GROUP BY i.invoice_id, i.final_amount
HAVING SUM(p.paid_amount) <> i.final_amount;


-- 2. Invoices with unusually high discounts
WITH discount_stats AS (
    SELECT 
        AVG(discount_applied) AS avg_discount
    FROM invoices
)
SELECT 
    invoice_id,
    discount_applied
FROM invoices
WHERE discount_applied > (SELECT avg_discount FROM discount_stats) * 2;


-- 3. Invoices with multiple refunds
SELECT 
    invoice_id,
    COUNT(refund_id) AS refund_count,
    SUM(refund_amount) AS total_refunded
FROM refunds
GROUP BY invoice_id
HAVING COUNT(refund_id) > 1;
