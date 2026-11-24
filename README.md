# EV Charging Station Usage Analytics

### MySQL & Power BI Data Analytics Project

## 1. Project Overview

The **EV Charging Station Usage Analytics** project analyzes electric vehicle (EV) charging session data to understand charging patterns, customer activity, charger utilization, and location performance.

MySQL is used for data cleaning, exploratory data analysis (EDA), and business queries. Power BI is used to create interactive dashboards with key performance indicators (KPIs), charts, and filters.

The main objective is to identify charging usage patterns and generate insights that can support better charging infrastructure planning and customer experience.

## 2. Project Objectives

- Analyze overall EV charging session activity.
- Identify locations with the highest charging activity.
- Compare charger types and charging companies.
- Understand monthly, daily, and hourly charging trends.
- Analyze customer usage and charging duration.
- Check missing values, duplicate records, and invalid data.
- Build an interactive Power BI dashboard for business analysis.

## 3. Tools and Technologies

- **MySQL 8.0** – Data cleaning, EDA, and SQL analysis.
- **Microsoft Power BI** – Interactive dashboard development.
- **SQL** – Data filtering, grouping, aggregation, and business queries.
- **DAX** – KPI calculations and measures.
- **CSV** – Source dataset format.

## 4. Dataset Description

The project uses an EV charging session dataset containing **72,856 records in the original raw table**.

The dataset contains information about charging sessions, users, chargers, locations, timestamps, charging duration, and charging demand.

### Important Columns

| Column | Description |
|---|---|
| `session_id` | Charging session identifier |
| `UserID` | User identifier |
| `ChargerID` | Charger identifier |
| `Location` | Charging station location |
| `ChargerType` | Type of charging equipment |
| `ChargerCompany` | Company associated with the charger |
| `StartDatetime` | Charging session start date and time |
| `StartTime` | Charging start-time information |
| `Duration_Minutes` | Session duration in minutes |
| `Demand` | Recorded charging demand value |

*Note: Column names may vary depending on the source dataset. The final cleaned row count may differ from the original raw row count.*

## 5. Project Workflow

### Step 1: Data Import

- Imported the source CSV dataset into MySQL.
- Created the `ev_charging_analytics` database.
- Stored the original data in the `charging_raw` table.
- Prepared the `charging_sessions` table for analysis.

### Step 2: Data Cleaning

- Checked column names and data types.
- Identified missing and blank values.
- Checked duplicate records and duplicate session IDs.
- Examined invalid or negative charging durations.
- Validated date and time values.
- Checked the logical sequence of charging timestamps.
- Converted columns to appropriate data types where required.

### Step 3: Exploratory Data Analysis (EDA)

Explored the dataset using SQL queries to understand:

- Total charging sessions.
- Unique users and chargers.
- Charging activity by location.
- Charging activity by charger type and company.
- Monthly and hourly charging patterns.
- Average charging duration.
- Charging demand distribution.

### Step 4: SQL Business Analysis

Used SQL queries, filtering, grouping, aggregation, and sorting to answer business questions about charging behavior and charger utilization.

### Step 5: Power BI Dashboard

Connected the analysis data to Power BI and designed a four-page interactive dashboard containing KPI cards, charts, and slicers.

## 6. SQL Business Questions

1. How many charging sessions are recorded in the dataset?
2. How many unique users and chargers are present?
3. Which locations have the highest charging activity?
4. Which charger types are used most frequently?
5. Which charger companies have the highest session counts?
6. How does charging activity change from month to month?
7. During which hours are charging sessions most frequent?
8. What is the average charging session duration?
9. How does charging activity vary across days of the week?
10. Are there missing values, duplicate records, or invalid duration values?

## 7. Power BI Dashboard Pages

### Page 1 – Overview
Provides a summary of overall EV charging activity.
<img width="936" height="548" alt="overview" src="https://github.com/user-attachments/assets/a9e245ef-7e88-46c6-93ec-b017207c1a82" />

**KPIs**
- Total Sessions
- Unique Users
- Active Chargers
- Average Duration
- Total Demand

**Visualizations**
- Monthly Charging Sessions
- Sessions by Location
- Charging Activity by Hour
- Sessions by Charger Type

### Page 2 – Charging Trends

Analyzes charging activity over time.
<img width="936" height="549" alt="charging trends" src="https://github.com/user-attachments/assets/bf61ccdc-aaef-49cf-818e-7fe5d1e28e29" />


**KPIs**
- Sessions This Period
- Average Daily Sessions
- Average Charging Duration

**Visualizations**
- Monthly Session Trend
- Sessions by Day of Week
- Average Duration Trend
- Hourly Sessions by Charger Type

### Page 3 – Charger & Location Analysis

Compares charger utilization across locations and companies.
<img width="934" height="548" alt="charger location performance" src="https://github.com/user-attachments/assets/ad78866b-ab27-4b67-9965-b779787eeee6" />

**KPIs**
- Total Locations
- Active Chargers
- Average Sessions per Location
- Total Sessions

**Visualizations**
- Charging Sessions by Location
- Charger Type by Location
- Active Chargers by Location
- Charging Activity by Company Across Locations

### Page 4 – Customer Usage & Charging Behavior

Analyzes customer activity, charging preferences, and session duration.
<img width="935" height="549" alt="customer usage analysis" src="https://github.com/user-attachments/assets/b508efec-11af-4c00-93a4-6ec6aa2c65b9" />

**KPIs**
- Unique Users
- Average Sessions per User
- Average Charging Duration
- Long Sessions (over 60 minutes)

**Visualizations**
- User Activity Distribution
- Customer Charging Preferences by Charger Type
- Average Charging Duration by Charger Type
- Long Sessions by Charging Hour

## 8. Interactive Dashboard Features

The dashboard includes slicers for:

- Location
- Charger Type
- Charger Company
- Session Date
- User ID on the customer analysis page

Users can filter the dashboard to explore charging activity across different locations, charger types, companies, users, and date ranges.

A consistent midnight-blue theme with blue and violet accents provides a unified dashboard design.

## 9. Key Business Benefits

- **Infrastructure Planning:** Identify locations with high charging activity.
- **Charger Utilization:** Compare usage across charger types and companies.
- **Operational Planning:** Understand peak charging hours and days.
- **Customer Behavior:** Explore charging preferences and usage frequency.
- **Data Reliability:** Identify missing, duplicate, and invalid records.
- **Decision Support:** Present charging patterns through interactive visualizations.

## 10. Skills Demonstrated

- MySQL and SQL querying
- Data cleaning and validation
- Exploratory Data Analysis (EDA)
- Data aggregation and filtering
- Business question formulation
- DAX measures and KPI development
- Power BI dashboard design
- Data visualization
- Analytical thinking and business interpretation

## 11. Project Structure

```text
EV-Charging-Station-Usage-Analytics/
│
├── dataset/
│   └── source_dataset.csv
│
├── sql/
│   └── ev_charging_analysis.sql
│
├── powerbi/
│   ├── EV_Charging_Analytics.pbix
│   └── EV_Charging_Executive_Midnight_Blue_Theme.json
│
├── screenshots/
│   ├── overview.png
│   ├── charging_trends.png
│   ├── charger_location_analysis.png
│   └── customer_usage.png
│
└── README.md
```



## 12. Conclusion

The EV Charging Station Usage Analytics project demonstrates an end-to-end data analytics workflow, from importing and cleaning raw data to performing SQL analysis and creating interactive Power BI dashboards.

The project explores charging trends, location performance, charger utilization, and customer behavior. It demonstrates practical SQL and Power BI skills that can be applied to real-world data analyst tasks.


