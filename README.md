# 📊 Customer Experience Intelligence: From Operational Analytics to Intelligent Automation

> **An end-to-end Customer Experience Intelligence solution that integrates data engineering, operational analytics, customer voice analytics, and AI-powered workflow automation to support proactive operational decision-making.**

---

<img src="https://www.salesforce.com/blog/wp-content/uploads/sites/2/2021/07/SFC-22038-Blog-Image-7-Principles-that-Spark-Business-Growth.jpg?w=889" width="100%">


## Project Overview

In today's digital economy, every customer interaction generates valuable operational and behavioral data. Beyond resolving customer requests, modern Customer Experience (CX) teams are responsible for continuously monitoring service quality, measuring operational efficiency, identifying bottlenecks, and understanding customer expectations in order to improve the overall customer journey.

As customer volume continues to grow, manually reviewing operational dashboards, service-level metrics, and thousands of customer feedback comments becomes increasingly time-consuming and reactive. Organizations therefore require an integrated analytical solution capable of transforming operational data into timely business insights while reducing manual reporting effort.

This project presents an end-to-end Customer Experience Operations Intelligence solution that combines data engineering, business intelligence, customer voice analytics, and AI-powered workflow automation into a unified analytical pipeline.

Starting from raw customer support data, the project performs data preparation, business-hour SLA calculation, operational KPI generation, interactive dashboard development, customer feedback analysis using Natural Language Processing (NLP), and finally an AI-assisted automation workflow capable of generating executive Morning Brief reports and Critical Alerts for daily operational monitoring.

Rather than building a traditional dashboard alone, this project demonstrates how analytics can evolve into an intelligent decision-support system by integrating structured operational metrics, unstructured customer feedback, and Large Language Models (LLMs) into a single automated workflow.

#### The project consists of 10 main parts:

```text
1. Business Objectives

2. Dataset Overview

3. Project Architecture

4. Data Engineering

5. Operational Performance Analytics

      5.1. CX Operations Overview
      5.2. Agent Performance Analysis
      5.3. Service Performance Analysis

6. Customer Voice Analytics

7. AI CX Operations Automation

8. Key Business Insights

9. Business Recommendations

10. Future Enhancements
```

---

# 1. Business Objectives

The primary objective of this project is to develop an integrated Customer Experience Operations Intelligence solution capable of supporting operational decision-making through data-driven analytics and intelligent automation.

Specifically, the project aims to:

- Build a reliable analytical dataset by integrating customer support ticket records with SLA tracking data.
- Measure operational performance through business-hour SLA calculations and operational KPIs.
- Analyze ticket volume, SLA compliance, agent productivity, and service-level performance using interactive dashboards.
- Discover recurring customer concerns through Customer Voice Analytics using Topic Modeling.
- Design an AI-powered automation workflow capable of automatically generating executive operational reports and critical incident alerts.

Ultimately, the project demonstrates how organizations can move beyond descriptive reporting by combining operational analytics and artificial intelligence to support faster, more informed managerial decisions.

---

# 2. Dataset Overview

The analytical workflow is built upon three operational datasets representing different aspects of Customer Experience operations. Together, these datasets provide both structured operational information and unstructured customer feedback required for comprehensive business analysis.

## Data_Ticket

The `Data_Ticket` dataset records every customer support request submitted to the Customer Experience team. Each record represents a single customer support ticket and contains information about when the ticket was created, which agent handled it, and which product or service category the request belongs to.

| Column | Description |
|---------|-------------|
| Ticket_id | Ticket identifier |
| Agent_tiep_nhan | Assigned support agent |
| Level | Service category |
| Created_date | Ticket creation date |

## Data_SLA

The `Data_SLA dataset` tracks the operational handling process after a ticket has been received. It contains timestamps required for calculating response performance and evaluating SLA compliance.

Unlike simply measuring elapsed time, this project calculates Actual SLA based on business working hours (Monday–Friday, 09:00–18:00), providing a more realistic measurement of operational performance.

**Service Level Agreement (SLA)** represents the committed response time for resolving customer requests. Actual SLA is calculated using business hours (Monday–Friday, 09:00–18:00).

| Column | Description |
|---------|-------------|
| Ticket_id | Ticket identifier |
| Chuyen_time | Assignment timestamp |
| Phanhoi_time | First response timestamp |
| SLA_Camket | Committed SLA (minutes) |

## Data_Suggestion

The `Data_Suggestion` dataset contains customer feedback collected after service interactions. Unlike the previous two datasets, which describe operational activities, this dataset captures customers' opinions, complaints, and improvement suggestions.

| Column | Description |
|---------|-------------|
| Feedback_Date | Submission date |
| contents | Customer feedback |


---

# 3. Project Architecture

The project consists of two analytical pipelines that eventually converge into a single AI-powered decision support workflow.

The first pipeline focuses on structured operational analytics. Ticket records and SLA logs are processed, validated, and transformed into operational KPIs before being visualized through interactive dashboards.

The second pipeline focuses on unstructured customer feedback. Customer comments are processed using Natural Language Processing techniques to identify recurring discussion themes and customer concerns.

Finally, insights generated from both analytical pipelines are integrated into an AI-powered automation workflow that continuously monitors operational performance and automatically generates executive reports.

```text
                    Data_Ticket
                         │
                    Data_SLA
                         │
                  Data Integration
                         │
                Business Hour SLA
                         │
                  Operational KPIs
                         │
                  Power BI Dashboard
                         │
                         ├──────────────────────┐
                         │                      │
Data_Suggestion          │                      │
        │                │                      │
        ▼                ▼                      ▼
 NLP Processing     Operational Insights   Customer Insights
        └────────────────┬─────────────────────┘
                         │
              AI CX Operations Automation
                         │
        ┌────────────────┴────────────────┐
        │                                 │
 Morning Brief                  Critical Alert
```

###Technology Stack

| Category | Technologies |
|----------|--------------|
| Data Processing | SQL Server, SQL |
| Visualization | Power BI |
| NLP | Python, Pandas, Scikit-learn, CountVectorizer, LDA |
| Automation | n8n |
| AI | OpenAI API |
| Storage | Google Sheets |


---

# 4. Data Engineering

The project begins by transforming raw operational data into a standardized analytical dataset suitable for business reporting and AI automation.

Ticket records and SLA logs are first validated to ensure primary key consistency, eliminate duplicate records, and identify missing values before being merged through Ticket ID.

A key challenge addressed during this stage is the calculation of Actual SLA. Instead of using simple timestamp differences, the project calculates Actual SLA exclusively during business working hours (Monday–Friday, 09:00–18:00), excluding weekends and non-working periods. This approach provides a significantly more accurate measurement of operational efficiency compared to conventional elapsed-time calculations.

Additional business features, including Delay Minutes, SLA Status, Reporting Date, Weekly Aggregation, and operational indicators, are subsequently generated to support dashboard reporting, anomaly detection, and AI-driven reporting.

The resulting analytical dataset serves as the single source of truth for every downstream component of the project.

---

# 5. Operational Performance Analytics

The operational analytics layer transforms processed ticket and SLA data into interactive dashboards that enable managers to monitor customer support performance from multiple business perspectives. Rather than presenting isolated KPIs, the dashboards are designed to identify operational trends, workload distribution, service quality, and potential performance bottlenecks.

The analytical solution consists of three dashboard pages, each focusing on a different operational dimension while collectively providing a comprehensive view of Customer Experience performance.

## 5.1. CX Operations Overview

(Dashboard Preview)

The Executive Dashboard provides a high-level overview of operational performance by consolidating ticket volume, SLA compliance, workload trends, and handling efficiency into a single reporting interface.

The analysis shows that a total of **5,187 customer** support tickets were processed during the reporting period, averaging approximately **371 tickets per week**. Ticket demand increased steadily throughout the quarter, reaching its highest level during Week 12 before declining sharply toward the end of the reporting period.

Despite the increasing workload, service performance did not improve accordingly. The overall SLA On-Time Rate reached only **41.85%**, indicating that fewer than half of all tickets were resolved within the committed service target. Weekly SLA performance gradually deteriorated after Week 3, eventually falling to only **25.23%** by Week 14. This divergence between ticket growth and SLA compliance suggests that operational capacity did not scale proportionally with customer demand, leading to increasing service pressure over time.

The distribution of Actual SLA further reveals that although most tickets were resolved within a relatively short period, a small number of exceptionally long-running cases significantly impacted overall operational performance. These outliers may indicate backlog accumulation, ticket complexity, or escalation processes requiring further operational investigation.


## 5.2. Agent Performance Analysis

(Dashboard Preview)

The Agent Performance dashboard evaluates operational workload and service quality at the individual agent level. By combining ticket volume, SLA compliance, and handling efficiency, the dashboard enables managers to identify both top-performing agents and potential operational bottlenecks.

The analysis reveals that ticket workload was distributed unevenly across the support team. One agent handled **1,913 tickets**, accounting for approximately **37% of all customer requests**, while the average workload per agent remained substantially lower. Such concentration increases operational dependency on a limited number of individuals and creates potential service continuity risks.

Performance comparison further indicates considerable variation in SLA compliance across agents. While the highest-performing agent achieved an SLA On-Time Rate exceeding **87%**, several agents recorded substantially lower performance despite managing fewer tickets. This suggests that ticket volume alone does not fully explain operational efficiency. Differences in ticket complexity, workload allocation, and handling practices likely contribute to these performance gaps.

Average handling time analysis also highlights several agents with exceptionally high Actual SLA values, suggesting prolonged ticket resolution, backlog accumulation, or operational inefficiencies that warrant further investigation.


## 5.3. Service Performance Analysis

(Dashboard Preview)

The Service Performance dashboard evaluates operational performance across different product and service categories, allowing management to identify which business areas contribute most significantly to SLA deterioration.

The analysis demonstrates substantial differences in service quality between product groups. Several services consistently maintained strong SLA compliance throughout the reporting period, whereas others experienced persistently poor operational performance. Rather than indicating organization-wide service issues, the findings suggest that SLA challenges are concentrated within a relatively small number of high-impact service categories.

The service-level heatmap further illustrates that while certain categories repeatedly achieved SLA compliance above 90%, high-volume services such as Mobile Top-up and Mobile Card Purchase experienced continuous SLA deterioration across multiple weeks. These findings suggest that targeted operational improvements within specific services may deliver greater business impact than broad organization-wide initiatives.


---

# 6. Customer Voice Analytics

Operational metrics explain how customer support operations perform, but they cannot fully explain why customers remain satisfied or dissatisfied. To complement structured operational analytics, this project incorporates Customer Voice Analytics to identify recurring customer concerns directly from customer feedback.

Rather than manually reviewing hundreds of comments, Natural Language Processing (NLP) techniques are applied to automatically discover discussion themes and transform unstructured customer feedback into actionable business insights.

** NLP Workflow:

(Workflow Figure)

The Customer Voice Analytics pipeline begins by preprocessing raw customer comments through text cleaning and normalization to improve data consistency. Stopwords and unnecessary symbols are subsequently removed before customer comments are transformed into a document-term matrix using CountVectorizer.

Latent Dirichlet Allocation (LDA) is then applied to identify latent discussion topics across the feedback dataset. Finally, each topic is manually interpreted into business-oriented customer issues that can be more easily understood by operational managers.

```text
Customer Feedback
        ↓
Text Cleaning
        ↓
Normalization
        ↓
CountVectorizer
        ↓
LDA Topic Modeling
        ↓
Topic Interpretation
        ↓
Business Insights
```

** Customer Voice Insights

The topic modeling results reveal several recurring themes consistently discussed by customers, including loan services, promotional programs, payment experience, account-related services, and application usability.

Unlike operational dashboards, which primarily monitor service efficiency, Customer Voice Analytics provides additional context regarding customer expectations and pain points. These qualitative insights complement structured KPIs by highlighting customer concerns that may not yet be reflected through operational metrics alone.

Together, structured operational data and unstructured customer feedback provide a more comprehensive understanding of Customer Experience performance, enabling managers to prioritize service improvements from both operational and customer perspectives.


---

# 7. AI CX Operations Automation

Traditional business intelligence dashboards require managers to actively monitor operational performance and manually interpret analytical results. To reduce manual reporting effort and enable more proactive decision-making, this project extends conventional analytics into an AI-assisted operational monitoring workflow.

The automation workflow was implemented using n8n, integrating operational KPIs, anomaly detection, customer feedback analysis, and Large Language Models into a unified reporting pipeline capable of automatically generating executive reports each morning.

** Workflow Architecture:

(Workflow Screenshot)

```text
Schedule Trigger
        ↓
Read Ticket
Read SLA
Read Feedback
        ↓
Merge
        ↓
Business Logic
        ↓
Daily KPI
        ↓
Anomaly Detection
        ↓
OpenAI
        ↓
Morning Brief
        ↓
Critical Alert
        ↓
Gmail
```

The workflow begins by retrieving the latest operational datasets before merging structured ticket information, SLA records, and customer feedback into a unified analytical dataset. Business logic is subsequently applied to calculate Actual SLA, generate operational KPIs, and evaluate service performance for the reporting period.

Anomaly Detection continuously monitors operational indicators to identify abnormal situations such as declining SLA compliance, excessive handling delays, overloaded agents, or deteriorating service performance. These anomalies are then incorporated into AI-generated executive reports together with customer feedback insights.

Finally, OpenAI generates structured HTML reports before automated email delivery distributes both the Morning Brief and Critical Alert reports to management.


### Workflow Components

| Node | Purpose |
|------|---------|
| Schedule Trigger | Execute every morning |
| Google Sheets | Load operational data |
| Merge | Combine datasets |
| Business Logic | Calculate Actual SLA |
| Daily KPI | Generate KPIs |
| Anomaly Detection | Detect operational risks |
| OpenAI | Generate executive reports |
| Gmail | Deliver reports |

The workflow automatically produces:
- AI Morning Brief
- AI Critical Alert

## Executive Reports

The automation workflow produces two AI-generated executive reports designed for different operational scenarios.

The **Morning Brief** provides a comprehensive daily operational summary, including Executive Summary, Operational KPI Dashboard, Critical Alerts, Agent Performance, Service Performance, Customer Voice Analytics, and recommended business actions.

The **Critical Alert** report is generated whenever operational anomalies exceed predefined thresholds. Instead of presenting routine daily performance, this report focuses exclusively on urgent operational risks, affected business areas, potential business impact, and immediate corrective actions requiring management attention.

Together, these reports demonstrate how traditional dashboard monitoring can evolve into an AI-assisted decision-support system capable of delivering concise operational intelligence directly to business stakeholders without requiring manual report preparation.

---

# 8. Key Business Insights

### Insight 1: Growing Workload Is Putting Pressure on Service Performance

Customer support demand increased steadily throughout the reporting period, with more than 5,000 tickets processed over fourteen weeks. However, operational performance did not improve at the same pace. As ticket volume grew, the overall SLA On-Time Rate gradually declined, suggesting that operational capacity was unable to scale proportionally with customer demand. This indicates a growing pressure on Customer Experience operations that may eventually affect service quality if left unaddressed.

### Insight 2: Workload Distribution Across Agents Is Highly Imbalanced

The analysis reveals that customer support workload is concentrated among a small number of agents, while others handle significantly fewer tickets. Such imbalance increases dependency on key personnel, creates operational bottlenecks, and raises the likelihood of SLA violations. A more balanced workload allocation could improve both operational efficiency and service consistency.

### Insight 3: Operational Issues Are Concentrated Within Specific Services

Service-level analysis shows that poor SLA performance is not evenly distributed across all business services. Instead, a limited number of high-volume service categories consistently experience lower SLA compliance. Prioritizing operational improvements within these critical services would likely generate greater business impact than implementing organization-wide changes.

### Insight 4: Customer Feedback Complements Operational Metrics

Operational dashboards explain how Customer Experience teams perform, while customer feedback explains why customers remain satisfied or dissatisfied. Topic Modeling identifies recurring concerns related to loan services, promotions, payments, account management, and application usability. Integrating these qualitative insights with operational KPIs provides a more complete understanding of customer experience and helps prioritize improvement initiatives.

### Insight 5: AI Enables Proactive Operational Decision-Making

Traditional dashboards require managers to manually review operational metrics before taking action. By integrating KPI monitoring, anomaly detection, customer feedback analysis, and Large Language Models into a single workflow, this project automatically generates executive Morning Briefs and Critical Alerts. The solution demonstrates how business intelligence can evolve into an AI-assisted decision support system that enables faster identification of operational risks while significantly reducing manual reporting effort.

---

# 9. Business Recommendations

### Recommendation 1: Improve Workload Allocation Across Support Agents

Implement workload balancing mechanisms that distribute tickets more evenly according to agent capacity, expertise, and historical performance. A more balanced allocation strategy can reduce operational bottlenecks while improving SLA compliance and overall service quality.

### ecommendation 2: Prioritize High-Impact Service Categories

Rather than allocating resources equally across all services, management should focus improvement efforts on service categories that combine high ticket volume with consistently poor SLA performance. Targeted optimization is likely to generate greater operational benefits while making more efficient use of available resources.

### Recommendation 3: Integrate Customer Voice Into Operational Monitoring

Customer feedback should become a regular component of operational performance evaluation instead of being reviewed separately. Combining Customer Voice Analytics with structured operational KPIs enables managers to better understand customer expectations, identify emerging issues earlier, and prioritize improvements based on real customer needs.

### Recommendation 4: Expand Intelligent Automation

The AI-powered workflow demonstrates that executive reporting can be generated automatically with minimal manual effort. Organizations should further extend intelligent automation into areas such as root cause analysis, predictive SLA monitoring, knowledge management, and operational decision support to enhance overall Customer Experience management.

### Recommendation 5: Establish a Data-Driven CX Management Framework

Rather than relying solely on periodic dashboard reviews, organizations should integrate data engineering, operational analytics, customer feedback, and AI-assisted reporting into a unified Customer Experience Intelligence framework. This approach enables continuous monitoring, faster response to operational risks, and more informed strategic decision-making.

---

# 10. Future Enhancements

***Real-Time Operational Monitoring

Replace scheduled batch processing with real-time data streaming to enable continuous monitoring of operational performance and faster detection of service disruptions.

***Predictive SLA Analytics

Develop machine learning models capable of forecasting SLA violations before they occur, allowing managers to proactively allocate resources and reduce potential service delays.

*** Advanced Customer Voice Analytics

Enhance the current topic modeling approach with sentiment analysis, aspect-based sentiment analysis, or Retrieval-Augmented Generation (RAG) to generate richer customer insights and more context-aware recommendations.

*** AI Operational Copilot

Extend the existing AI workflow into an interactive operational assistant capable of answering business questions, explaining KPI changes, identifying root causes, and recommending corrective actions through natural language conversations.

*** Enterprise Data Integration

Integrate the solution with enterprise CRM, Customer Data Platform (CDP), ticketing systems, and data warehouses to support larger-scale deployments and enable organization-wide Customer Experience Intelligence.


---

## Author

**Minh Nguyen** 🐧

---

## 📫 Connect With Me

- LinkedIn: https://www.linkedin.com/in/minh-nguyen-9016a627a/
- Email: minhnguyen29p304@gmail.com

---

⭐ Nothing is impossible
💫 Learn, learn more, learn forever
