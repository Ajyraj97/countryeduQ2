# CountryEdu Question 2 — Client Churn Risk & Revenue Forecasting

## Completed case-study project

### Exact business scope
- 200 enterprise clients
- 10,000,000 synthetic transaction records
- 12% financial-data missingness
- 18% baseline churn
- 3-month churn prediction horizon
- 12-month revenue forecast
- 5% relative churn-reduction target

### Churn definition
The target variable `churn_next_3m` equals 1 when the client is classified as a churn-risk outcome for the three-month horizon following the observation month. The classification is based on observable customer-health signals: CSAT, SLA compliance, payment delays, escalations, support volume, contract timing and revenue trend.

### Churn-reduction target
The requested 5% reduction is interpreted as relative reduction:
18% × 95% = 17.1% target churn.

### Modeling unit
The raw transaction level is not used as the customer-level prediction unit. Transactions are aggregated to client-month features so each enterprise client contributes a comparable customer-health observation.

### Missing financial data
Exactly 12% of synthetic transaction financial values are marked missing. The missingness flag is retained. Numerical modeling features use training-set median imputation inside the model pipeline.

### Models
Logistic Regression and XGBoost are evaluated on a time-based holdout. The selected model is Logistic Regression. PR-AUC is the primary model-selection metric because churn is imbalanced; ROC-AUC is secondary.

### Financial prioritization
Expected revenue loss = churn probability × annualized client revenue.

This is the main retention-priority metric.

### Revenue forecast
Monthly revenue is forecast using Holt-Winters exponential smoothing with additive trend and 12-month seasonality. The final six historical months are used as a backtest.

### Project contents
- `data/client_master.csv`
- `data/client_month_features.csv`
- `data/transactions_preview_100k.csv`
- `data/transactions_10m_chunks/transactions_part_01.npz` through `transactions_part_10.npz` — exactly 10,000,000 transaction records
- `outputs/model_comparison.csv`
- `outputs/client_churn_risk_scores.csv`
- `outputs/top_churn_factors.csv`
- `outputs/revenue_forecast_12m.csv`
- `outputs/retention_action_plan.csv`
- `outputs/executive_summary_metrics.csv`
- `outputs/latest_client_health.csv`
- `outputs/client_month_modeling_table.csv`
- `charts/`
- `sql/analysis.sql`
- final PDF report
- final PowerPoint presentation
