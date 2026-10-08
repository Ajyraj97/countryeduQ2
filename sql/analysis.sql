-- CountryEdu Question 2 analytical SQL
SELECT client_id, DATE_TRUNC('month', transaction_date) AS month,
       SUM(transaction_amount) AS monthly_revenue,
       COUNT(*) AS transaction_count,
       AVG(payment_delay_days) AS avg_payment_delay
FROM transactions_10m
GROUP BY client_id, DATE_TRUNC('month', transaction_date);

WITH monthly AS (
 SELECT client_id, DATE_TRUNC('month', transaction_date) AS month,
        SUM(transaction_amount) AS revenue
 FROM transactions_10m
 GROUP BY client_id, DATE_TRUNC('month', transaction_date)
)
SELECT client_id, month, revenue,
       revenue / NULLIF(LAG(revenue,3) OVER(PARTITION BY client_id ORDER BY month),0)-1 AS revenue_3m_growth
FROM monthly;

SELECT client_id, month, churn_next_3m
FROM client_month_features;

SELECT client_id, churn_probability, annualized_revenue,
       churn_probability*annualized_revenue AS expected_revenue_loss
FROM client_churn_risk_scores
ORDER BY expected_revenue_loss DESC;
