# 🍕 Pizza Sales Analytics Dashboard

> **Tools Used:** MySQL | Tableau Public
> **Dataset:** 4 Tables | 48,620 Orders | $817,860 Total Revenue

🔗 **[View Live Dashboard on Tableau Public](https://public.tableau.com/views/PizzaSalesAnalyticsDashboard_17766667725500/Dashboard1)**

---

## 📌 Objective

Analyze Pizza Hut sales data using SQL to uncover customer ordering patterns, revenue streams, and top-performing pizza categories. Visualized findings in an interactive Tableau dashboard.

---

## 📊 Dashboard Preview

[![Pizza Sales Dashboard](https://public.tableau.com/static/images/Pi/PizzaSalesAnalyticsDashboard_17766667725500/Dashboard1/1_rss.png)](https://public.tableau.com/views/PizzaSalesAnalyticsDashboard_17766667725500/Dashboard1)

🔗 [Click here to explore the interactive dashboard](https://public.tableau.com/views/PizzaSalesAnalyticsDashboard_17766667725500/Dashboard1)

---

## 🗃️ Dataset Structure

| Table | Key Columns | Description |
|-------|-------------|-------------|
| `pizzas` | pizza_id, pizza_type_id, size, price | Pizza variants and pricing |
| `pizza_types` | pizza_type_id, name, category, ingredients | Pizza names and categories |
| `orders` | order_id, date, time | Order date and time |
| `order_details` | order_details_id, order_id, pizza_id, quantity | Items per order |

---

## 🔍 Key Insights

| Metric | Value |
|--------|-------|
| 📦 Total Orders | 21,350 |
| 💰 Total Revenue | $817,860 |
| 🛒 Total Pizzas Sold | 48,620 |
| 💵 Average Orders Per Day | 138 |
| 🍕 Most Ordered Size | Large (L) — 18,526 orders |
| 👑 Highest Priced Pizza | The Greek XXL — $35.95 |
| 🏆 Top Pizza by Revenue | The Thai Chicken Pizza — $43,434 |
| 🔥 Top Category | Classic — 14,888 units sold |
| ⏰ Peak Order Hour | 12 PM — 2,520 orders |

---

## 📂 Analysis Breakdown

### 🟢 Basic Analysis
| # | Question | Result |
|---|----------|--------|
| 1 | Total number of orders | 21,350 |
| 2 | Total revenue | $817,860 |
| 3 | Highest priced pizza | The Greek XXL ($35.95) |
| 4 | Most ordered size | Large (18,526 orders) |
| 5 | Top 5 pizzas by quantity | classic_dlx, bbq_ckn, hawaiian, pepperoni, thai_ckn |

### 🟡 Intermediate Analysis
| # | Question | Result |
|---|----------|--------|
| 1 | Total quantity by category | Classic(14,888) > Supreme(11,987) > Veggie(11,649) > Chicken(11,050) |
| 2 | Orders by hour of day | Peak: 12 PM (2,520), Evening peak: 6 PM (1,920) |
| 3 | Order distribution by pizza name | Classic Deluxe leads with 2,453 units |
| 4 | Avg pizzas ordered per day | 138 |
| 5 | Top 3 pizzas by revenue | Thai Chicken($43,434), BBQ Chicken($42,768), Cali Chicken($41,410) |

### 🔴 Advanced Analysis
| # | Question | Technique Used |
|---|----------|----------------|
| 1 | Revenue % contribution per pizza | Window Function — SUM OVER() |
| 2 | Cumulative revenue growth over time | Window Function — SUM OVER (ORDER BY date) |
| 3 | Top 3 pizzas per category by revenue | Window Function — DENSE_RANK OVER (PARTITION BY category) |

---

## 🛠️ SQL Concepts Used

- `JOIN` — combining multiple tables (orders, order_details, pizzas, pizza_types)
- `GROUP BY / ORDER BY` — aggregating sales by category, size, and time
- `ROUND / COUNT / SUM / AVG` — calculating revenue and order metrics
- `LIMIT` — filtering top N results
- `HOUR()` — extracting hour from time column
- `CTEs (WITH clause)` — calculating average daily orders cleanly
- `Window Functions` — DENSE_RANK, SUM OVER, PARTITION BY for advanced analytics

---

## 📁 Files in this Repository

| File | Description |
|------|-------------|
| `pizza_sales_queries.sql` | All SQL queries — Basic, Intermediate & Advanced |
| `pizza_sales_dashboard.twbx` | Tableau workbook file |
| `README.md` | Project documentation |

---

## ▶️ How to Run

1. Clone this repository
2. Import the 4 CSV files into MySQL / any SQL editor
3. Run queries from `pizza_sales_queries.sql` section by section
4. Open `pizza_sales_dashboard.twbx` in Tableau Desktop or Tableau Public

---

## 👤 Author

**Senapathi Krishna Sai**
Data Analyst | SQL | Python | Tableau | Excel

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](https://linkedin.com/in/senapathi-krishna-sai-a54721388)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=flat&logo=github&logoColor=white)](https://github.com/senapathi402-star)
[![Tableau](https://img.shields.io/badge/Tableau-E97627?style=flat&logo=tableau&logoColor=white)](https://public.tableau.com/views/PizzaSalesAnalyticsDashboard_17766667725500/Dashboard1)
