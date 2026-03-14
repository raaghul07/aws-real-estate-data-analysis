# ☁️ AWS Real Estate Data Analysis (S3 + Athena)

Serverless cloud data analysis of 1M+ US real estate listings using Amazon S3 and Amazon Athena — no servers, no databases, just SQL on cloud storage.

## 🏗️ Architecture
```
CSV Dataset → Amazon S3 → AWS Glue Data Catalog → Amazon Athena → SQL Insights
```

## 📊 Project Overview
This project demonstrates a serverless data analysis pipeline on AWS. The dataset is stored in S3 and queried directly using Athena — no database setup or servers required.

## 🛠️ AWS Services Used
- **Amazon S3** — Cloud storage for the raw CSV dataset
- **Amazon Athena** — Serverless SQL query engine on top of S3
- **AWS Glue Data Catalog** — Metadata store for table schema

## 📁 Dataset
- **Source:** [USA Real Estate Dataset - Kaggle](https://www.kaggle.com/datasets/ahmedshahriarsakib/usa-real-estate-dataset)
- **Size:** 1M+ listings across the US
- **Storage:** Stored in S3 as CSV, queried without any ETL

## 🔍 Key Queries & Findings

### Average Price by State
- California is the most expensive state (avg $774k, 218k listings)
- Hawaii and DC follow closely behind
- Massachusetts ranks 5th at avg $617k

### Most Listed Cities
- Houston leads with 23,603 listings at avg $475k
- New York City has the highest avg price at $2.26M
- Los Angeles averages $1.9M

### Price by Bedroom Count
- 3-bedroom homes are most common (753k listings)
- Price scales clearly: 1 bed avg $372k → 10 bed avg $2.6M

## 📝 SQL Queries

### Price Analysis by State
```sql
SELECT state, 
       COUNT(*) as total_listings,
       ROUND(AVG(price), 0) as avg_price,
       ROUND(MIN(price), 0) as min_price,
       ROUND(MAX(price), 0) as max_price
FROM real_estate_db.properties
WHERE price > 0 AND price < 3000000
GROUP BY state
ORDER BY avg_price DESC;
```

### Top Cities by Listings
```sql
SELECT city, state,
       COUNT(*) as total_listings,
       ROUND(AVG(price), 0) as avg_price
FROM real_estate_db.properties
WHERE price > 0
GROUP BY city, state
ORDER BY total_listings DESC
LIMIT 10;
```

### Price by Bedroom Count
```sql
SELECT CAST(bed AS INT) as bedrooms,
       COUNT(*) as total,
       ROUND(AVG(price), 0) as avg_price
FROM real_estate_db.properties
WHERE price > 0 AND bed > 0 AND bed <= 10
GROUP BY CAST(bed AS INT)
ORDER BY bedrooms;
```

## 💡 Key Takeaways
- Serverless SQL with Athena requires zero infrastructure setup
- S3 + Athena is cost-effective — pay only per query (per TB scanned)
- This architecture scales to billions of rows without any configuration
