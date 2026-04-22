# 🛒 Retail Sales Analysis — Advanced SQL Project

## Project Overview

A comprehensive SQL project analysing retail sales data across customers, products, and orders. This project demonstrates advanced SQL skills including window functions, CTEs, subqueries, stored procedures, and query optimisation — all applied to realistic retail business scenarios.

---

## Business Questions Answered

- Which products and categories generate the most revenue?
- Who are the highest-value customers and how do they rank by state?
- How is revenue trending month over month?
- Which products are dead stock (never ordered)?
- Which orders exceed the average order value?
- What does the overall sales performance look like across any date range?

---

## Database Schema

```
customers ──────< orders ──────< order_items >────── products
```

| Table | Description |
|---|---|
| `customers` | Customer details including location and signup date |
| `products` | Product catalogue with category, price, and stock |
| `orders` | Order headers linked to customers |
| `order_items` | Line items linking orders to products with quantity and price |

---

## Queries Included

| # | Query | Techniques Used |
|---|---|---|
| 1 | Total Revenue by Month | Aggregation, Date formatting |
| 2 | Top 5 Best-Selling Products | JOIN, GROUP BY, ORDER BY |
| 3 | Customer Lifetime Value | 3-table JOIN, Aggregation |
| 4 | Revenue by State | Geographic breakdown |
| 5 | Running Total Revenue | CTE, Window Function (SUM OVER) |
| 6 | Customer Ranking by State | CTE, Window Function (RANK OVER PARTITION) |
| 7 | Month-over-Month Growth | Window Function (LAG) |
| 8 | Products Never Ordered | NOT IN Subquery |
| 9 | High-Value Orders Above Average | HAVING, Nested Subquery |
| 10 | Category Performance Summary | CTE, Aggregation |
| 11 | Sales Summary Stored Procedure | Stored Procedure with parameters |

---

## Key SQL Concepts Demonstrated

`JOINs` `GROUP BY` `HAVING` `CTEs` `Subqueries` `Window Functions` `LAG` `RANK` `PARTITION BY` `Stored Procedures` `Date Functions` `Aggregations`

---

## How to Run

1. Open your SQL client (MySQL Workbench, DBeaver, or similar)
2. Run the full script in order — schema first, then data, then queries
3. To test the stored procedure: `CALL GetSalesSummary('2023-01-01', '2023-12-31');`

---

## Tools Used

- **MySQL** — database and query execution
- **MySQL Workbench** — development environment

---

## Author

**Mubin Fathima Johnkhan**
Data Analyst | Brisbane, QLD
📧 jmubinfathima@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/mubin-fathima-johnkhan-824249106)

---

*Part of my data analytics portfolio. See also: [Australian Property Market Analysis — Power BI & SSRS](https://github.com/MubinFathima/property-analysis-powerbi)*
