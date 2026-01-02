                                      Telecom Churn Analysis & Retention Strategy

                                                                         
📋 Project Overview

This project identifies a critical "Service Gap" in a fictional California-based Telecommunications company. By analyzing data for 7,043 customers, I identified that the most profitable segment—High-Value Fiber Optic users—is at the highest risk of churn. I proposed a technical solution to bridge this gap using automated retention triggers and a predictive dashboard.


🚀 The Business Problem

Overall Churn Rate: 26.54%

Revenue Hemorrhage: San Diego is losing $385,446 in revenue due to a staggering 64.91% churn rate.

The Gap: Fiber Optic users without "Premium Tech Support" are 2x more likely to churn than those with it.


🛠️ Technical Stack

SQL (MySQL): Data extraction, cleaning, and complex analytical views.

Python (Pandas/Seaborn): Exploratory Data Analysis (EDA) and churn driver identification.

Tableau: Interactive Executive Dashboard.

Lucidchart/Figma: User Story Mapping and BRD Documentation.


📊 Key Discoveries

The "Fiber-Support Gap": High-value Fiber users churn at 40.72%. Adding tech support reduces this risk by nearly 50%.

Contract Vulnerability: 88.5% of churned customers are on Month-to-Month contracts.

Competitor Poaching: 45% of churn is driven by competitors offering better hardware/speeds.


📁 Project Structure

/SQL_Scripts: Contains views for Geographic Risk, Service Gaps, and Tenure Dropoff.

/Python_EDA: Jupyter notebook for data cleaning and statistical analysis.

/Documentation: Business Requirements Document (BRD) and User Story Maps.

/Tableau_Dashboard: Link to the interactive workbook.

💡 Proposed Solution

1. Proactive Infrastructure & Hardware Refresh (Geographic Strategy)
The Problem: Your data shows that cities like San Diego (64.91% churn) and Fallbrook (60.47% churn) are in a "Revenue Death Spiral."

BTSA Requirement: Integrate a Network Health API with the Customer CRM. If a neighborhood in San Diego experiences more than three technical "micro-outages" in a month, the system should automatically trigger a ticket for the local field team.

Business Impact: This shifts the company from reactive (waiting for a customer to complain) to proactive (fixing the line before the customer notices), effectively neutralizing the "Product Dissatisfaction" churn driver.

2. The "Smart-Bundle" Logic (Product & Service Strategy)
The Problem: High-value Fiber Optic users without Premium Tech Support are your highest flight risk.

BTSA Requirement: Develop a Business Rule Engine (BRE) in the billing system. If a customer has "Fiber Optic" and "Total Charges > $5,000," but "Premium Tech Support = No," the system should offer a 0-dollar "Loyalty Support" add-on at the point of contract renewal.

// Business Impact: This increases the "switching cost" for the customer. Once they become accustomed to 24/7 technical support, they are significantly less likely to switch to a competitor for a minor price difference.

3. Automated "Contract-Cliff" Engagement (Sales & Automation)
The Problem: 88% of churners are on Month-to-Month contracts.

* BTSA Requirement:-> Implement a Predictive Alert System that flags Month-to-Month users at their 10th month of tenure. Use a "Decision Tree" to send a personalized incentive (e.g., a "Streaming Music" or "Unlimited Data" upgrade) conditional on signing a 12-month contract.

// Business Impact:-> Stabilizes Monthly Recurring Revenue (MRR) by converting volatile month-to-month cash flow into predictable annual revenue.


