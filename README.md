# 🎯 Customer Support Intelligence: From Operational Analytics to Intelligent Automation

> **An end-to-end Customer Support Intelligence solution that integrates data engineering, operational analytics, customer voice analytics, and AI-powered workflow automation to support proactive operational decision-making.**

---

<img src="https://www.salesforce.com/blog/wp-content/uploads/sites/2/2021/07/SFC-22038-Blog-Image-7-Principles-that-Spark-Business-Growth.jpg?w=889" width="100%">


## Project Overview

In today's digital economy, every customer interaction generates valuable operational and behavioral data. Beyond resolving customer requests, modern customer support teams are responsible for continuously monitoring service quality, measuring operational efficiency, identifying operational bottlenecks, and understanding customer concerns to improve service delivery.

As customer volume continues to grow, manually reviewing operational dashboards, service-level metrics, and thousands of customer feedback comments becomes increasingly time-consuming and reactive. Organizations therefore require an integrated analytical solution capable of transforming operational data into timely business insights while reducing manual reporting effort.

This project presents an end-to-end Customer Support Intelligence solution that combines data engineering, business intelligence, customer voice analytics, and AI-powered workflow automation into a unified analytical pipeline.

Starting from raw customer support data, the project performs data preparation, business-hour SLA calculation, operational KPI generation, interactive dashboard development, customer feedback analysis using Natural Language Processing (NLP), and an AI-powered workflow that automatically generates executive Morning Briefs and Critical Alerts for daily operational monitoring.

#### The project consists of 9 main parts:

```text
1. Business Objectives

2. Dataset Overview

3. Project Architecture

4. Operational Performance Analytics

      4.1. CX Operations Overview
      4.2. Agent Performance Analysis
      4.3. Service Performance Analysis

5. Customer Voice Analytics

6. AI CX Operations Automation

7. Key Business Insights

8. Business Recommendations

9. Future Enhancements
```

---

# 1. Business Objectives

The primary objective of this project is to develop an integrated Customer Support Intelligence solution capable of supporting operational decision-making through data-driven analytics and intelligent automation.

Specifically, the project aims to:

- Build a reliable analytical dataset by integrating customer support ticket records with SLA tracking data.
- Measure operational performance through business-hour SLA calculations and operational KPIs.
- Analyze ticket volume, SLA compliance, agent productivity, and service-level performance using interactive dashboards.
- Analyze customer feedback using NLP Topic Modeling to identify recurring support issues and customer concerns.
- Design an AI-powered automation workflow capable of automatically generating executive operational reports and critical incident alerts.

Ultimately, the project demonstrates how organizations can move beyond descriptive reporting by combining operational analytics and artificial intelligence to support faster, and more informed operational decision-making.

---

# 2. Dataset Overview

The analytical workflow is built upon three operational datasets representing different aspects of customer support operations in a **fintech business**. Together, these datasets provide both structured operational information and unstructured customer feedback required for comprehensive business analysis.

## Data_Ticket

The `Data_Ticket` dataset records every customer support request submitted to the Customer Support team. Each record represents a single customer support ticket and contains information about when the ticket was created, which agent handled it, and which product or service category the request belongs to.

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

The project consists of two analytical pipelines that eventually converge into a unified AI-powered operational reporting workflow.

The first pipeline focuses on structured operational analytics. Customer support ticket records and SLA logs are first processed and integrated using **SQL Server**, where data validation, business-hour SLA calculation, and feature engineering are performed to generate operational KPIs. These metrics are then visualized through interactive **Power BI** dashboards, enabling managers to monitor ticket volume, SLA compliance, agent performance, and service-level performance.

The second pipeline focuses on unstructured customer feedback. Customer comments are processed in Python using **Natural Language Processing (NLP)** techniques, including text preprocessing, CountVectorizer, and **Latent Dirichlet Allocation (LDA)** topic modeling, to identify recurring discussion themes and transform customer feedback into actionable business insights.

Finally, insights generated from both analytical pipelines are integrated into an automated workflow developed in **n8n**. The workflow combines operational KPIs, anomaly detection results, and customer voice insights before leveraging the **OpenAI API** to generate AI-powered Morning Briefs and Critical Alerts, which are automatically delivered to management via **Gmail**.

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
Data_Suggestion                            │
        │                                  │                      
NLP Processing                             │                      
        │                                  │                     
        ▼                                  ▼                     
Customer Insights               Operational Insights   
        └──────────────────────────────────┘
                         │
              AI CX Operations Automation
                         │
        ┌────────────────┴────────────────┐
        │                                 │
 Morning Brief                  Critical Alert
```

### 🛠️ Tools Used

| Technology | Purpose | Key Deliverables |
|------------|---------|------------------|
| <img src="https://img.shields.io/badge/Microsoft_SQL_Server-CC2927?style=flat-square&logo=microsoftsqlserver&logoColor=white"> | Data Engineering | Data validation, ETL, business-hour SLA calculation, feature engineering, KPI generation |
| <img src="https://img.shields.io/badge/Power_BI-F2C811?style=flat-square&logo=powerbi&logoColor=black"> | Business Intelligence | Executive dashboard, agent performance analysis, service performance analysis |
| <img src="https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white"> | Customer Voice Analytics | Text preprocessing, CountVectorizer, LDA Topic Modeling, customer insight extraction |
| <img src="https://img.shields.io/badge/n8n-EA4B71?style=flat-square&logo=n8n&logoColor=white"> | Workflow Automation | Automated data pipeline, KPI aggregation, anomaly detection, AI orchestration |
| <img src="https://img.shields.io/badge/OpenAI_API-412991?style=flat-square&logo=openai&logoColor=white"> | AI Integration | Morning Brief generation, Critical Alert generation, executive reporting |

---


# 4. Operational Performance Analytics

The operational analytics layer transforms processed Ticket and SLA data into interactive Power BI dashboards that provide a comprehensive view of customer support performance. Rather than presenting isolated KPIs, the dashboards help managers monitor operational workload, SLA compliance, agent productivity, and service-level performance, enabling faster identification of operational bottlenecks and improvement opportunities.

The analytical solution consists of three dashboard pages, each focusing on a different operational perspective while collectively providing a complete view of Customer Support operations.

## 4.1. CX Operations Overview

<img src="https://github.com/minhnguyen290304/Customer-Experience-Intelligence-From-Operational-Analytics-to-Intelligent-Automation/blob/main/dashboard%20preview/Ticket%20and%20SLA%20Performance%20Overview.png?raw=true" width="100%">

The Executive Dashboard consolidates key operational metrics into a single reporting interface, allowing managers to monitor ticket demand, SLA performance, workload trends, and handling efficiency.

During the analysis period, a total of **5,187 customer support tickets** were processed, averaging **371 tickets per week**. Ticket demand fluctuated throughout the quarter, peaking at **565 tickets in Week 12** before dropping sharply to **111 tickets in Week 14**, indicating significant variations in customer support demand over time.

Although ticket volume increased steadily toward the end of the reporting period, operational performance did not improve accordingly. The overall **SLA On-Time Rate was only 41.85%**, meaning fewer than half of all tickets were resolved within the committed SLA. Weekly SLA performance reached its highest level of **58.02% in Week 3** before declining continuously to **25.23% in Week 14**, suggesting that operational capacity did not scale sufficiently with the growing workload.

The distribution of Actual SLA is highly skewed. While most tickets were resolved within a relatively short timeframe, a small number of exceptionally long-running cases significantly increased the average handling time, indicating potential backlog accumulation, ticket escalation, or process bottlenecks requiring further operational investigation.

## 4.2. Agent Performance Analysis

<img src="https://github.com/minhnguyen290304/Customer-Experience-Intelligence-From-Operational-Analytics-to-Intelligent-Automation/blob/main/dashboard%20preview/Agent%20Performance.png?raw=true" width="100%">

The Agent Performance dashboard evaluates individual performance by combining ticket workload, SLA compliance, and average handling time, enabling managers to identify both high-performing agents and operational risks.

The analysis reveals a highly uneven workload distribution across the support team. **ngan.pham1** handled **1,913 tickets**, representing approximately **37% of all customer requests**, while the average workload per agent was only **472 tickets**. Such concentration creates operational dependency on a limited number of agents and increases service continuity risk.

Performance comparison also highlights significant differences in service quality. **crm_users** achieved the highest **SLA On-Time Rate of 87.39%** while recording the fastest average handling time (**272 minutes**). In contrast, **thuy.nguyen5** achieved only **19.23% SLA compliance**, resulting in a performance gap of more than **68 percentage points** between the highest- and lowest-performing agents.

Interestingly, workload alone does not fully explain operational performance. Despite handling the largest number of tickets, **ngan.pham1** maintained an SLA On-Time Rate close to the overall average (approximately **42%**), suggesting that factors such as ticket complexity, workload allocation, and operational practices have a greater influence on service quality than ticket volume alone.

Several agents also recorded exceptionally high average Actual SLA values exceeding **15,000 minutes**, indicating potential backlog accumulation, complex cases, or operational inefficiencies that warrant further investigation.

## 4.3. Service Performance Analysis

<img src="https://github.com/minhnguyen290304/Customer-Experience-Intelligence-From-Operational-Analytics-to-Intelligent-Automation/blob/main/dashboard%20preview/Product%20Service%20Analysis.png?raw=true" width="100%">

The Service Performance dashboard evaluates operational performance across product and service categories, allowing management to identify which business areas contribute most significantly to SLA deterioration.

Service quality varies considerably across product groups, with SLA On-Time Rates ranging from **100% to 0%**. High-performing services include **Online Television (100%)**, **Public Services (91.09%)**, and **Utility Telecommunications (87.88%)**, all of which consistently maintained strong SLA compliance throughout the reporting period.

Conversely, several services demonstrated critically poor performance. **Features**, **Apartment Services**, and **Transfer to MoMo Wallet** all recorded **0% SLA compliance**, meaning none of their tickets were resolved within the committed SLA target.

From a workload perspective, customer demand is heavily concentrated in only a few services. **Mobile Card Purchase (1,603 tickets)** and **Mobile Top-up (887 tickets)** account for a substantial proportion of total ticket volume while maintaining relatively poor SLA performance (**37.37%** and **21.65%**, respectively). This combination of high workload and low SLA compliance makes these services priority candidates for operational improvement.

Delay severity analysis further shows that **Transfer & Receive Money** recorded the highest average delay time (approximately **17.9K minutes**), followed by **Features (13.2K minutes)** and **Utility Telecommunications (11.1K minutes)**, indicating prolonged ticket resolution within specific service categories.

Finally, the Service × Week performance matrix reveals that SLA compliance fluctuates considerably across weeks for several services. These findings suggest that operational issues are influenced not only by service type but also by changing workload patterns and resource availability over time, highlighting opportunities for targeted operational improvements rather than organization-wide process changes.

---

# 5. Customer Voice Analytics

While operational dashboards reveal **how** customer support performs, they cannot fully explain **why** customers remain satisfied or dissatisfied. To complement structured operational metrics, this project incorporates Customer Voice Analytics to analyze unstructured customer feedback and uncover recurring customer concerns at scale.

The `Data_Suggestion` dataset consists of open-ended customer comments collected from users. Because manually reviewing thousands of comments is both time-consuming and difficult to scale, Natural Language Processing (NLP) and Topic Modeling were applied to automatically identify the dominant discussion themes and transform customer feedback into actionable business insights.

**NLP Workflow**:

The Customer Voice Analytics pipeline begins by cleaning and standardizing raw customer comments. After text normalization, tokenization, and stopword removal, customer comments are transformed into a document-term matrix using **CountVectorizer**. Multiple **Latent Dirichlet Allocation (LDA)** models are then evaluated using the **Topic Coherence Score** to determine the most appropriate number of topics before each topic is interpreted from a business perspective. Finally, each topic is manually interpreted into business-oriented customer issues that can be more easily understood by operational managers.

<img src="https://github.com/minhnguyen290304/Customer-Experience-Intelligence-From-Operational-Analytics-to-Intelligent-Automation/blob/main/workflows/NLP%20Workflow.png?raw=true" width="100%">

To determine the optimal number of discussion topics, multiple LDA models were evaluated using the **Topic Coherence Score**. The final model was configured with **six topics**, providing clearer topic separation and better business interpretability while maintaining strong semantic coherence.

The six identified customer discussion themes are presented below.

**Topic Distribution**

| No. | Topic | Representative Keywords | Share | Business Insight |
|----:|-------|-------------------------|------:|------------------|
| 1 | Rewards & Gamification | xu, voucher, ưu_đãi, nhiệm_vụ, trò_chơi, game | 21.1% | Customers expect richer loyalty programs, cashback campaigns, vouchers, and more engaging gamification features. |
| 2 | Loan & Credit Services | vay, hạn_mức, lãi, thanh_toán, trả | 20.3% | Users request higher credit limits, faster approvals, clearer repayment information, and more flexible lending services. |
| 3 | Wallet Account & Financial Management | tài_khoản, giao_dịch, thanh_toán, ngân_hàng | 19.1% | Customers seek improved account management, transaction visibility, and smoother financial operations. |
| 4 | Debt Collection & Payment Reminder Experience | gọi, nhắc, nợ, hạn, nhân_viên | 17.0% | Customers expect more personalized and customer-friendly reminder communications. |
| 5 | Payment & Bank Integration Experience | ví, chuyển, ngân_hàng, liên_kết, thông_báo | 14.6% | Users seek a more seamless payment experience with reliable bank integration and transaction notifications. |
| 6 | App UI/UX & Feature Enhancement | app, giao_diện, dark_mode, lag, tính_năng | 7.9% | Customers request interface improvements, better performance, and enhanced application usability. |

###

<img src="https://github.com/minhnguyen290304/Customer-Experience-Intelligence-From-Operational-Analytics-to-Intelligent-Automation/blob/main/visuals/TopicDistribution.png?raw=true" width="100%">

###

<img src="https://github.com/minhnguyen290304/Customer-Experience-Intelligence-From-Operational-Analytics-to-Intelligent-Automation/blob/main/visuals/Word%20Cloud.png?raw=true" width="100%">


The topic modeling results reveal that customer feedback extends far beyond issue resolution. **Rewards & Gamification (21.1%)** and **Loan & Credit Services (20.3%)** together account for over **41%** of all suggestions, indicating strong customer demand for continuous product innovation and service enhancement.

Beyond product features, customers also emphasize the overall service experience. Topics related to **Debt Collection**, **Payment & Bank Integration**, and **Wallet Management** highlight expectations for smoother financial transactions, transparent communication, and more personalized customer interactions. Although **App UI/UX & Feature Enhancement** represents the smallest topic (7.9%), it reflects growing expectations for a modern, responsive, and intuitive mobile application.

Together with the operational dashboards, Customer Voice Analytics provides a more comprehensive understanding of Customer Experience by combining structured operational metrics with unstructured customer feedback, enabling managers to prioritize improvements from both operational and customer perspectives.


---

## 6. AI CX Operations Automation

Traditional business intelligence dashboards require managers to actively monitor operational performance and manually interpret analytical results. While dashboards provide valuable visibility into operational KPIs, they still rely on users to regularly access reports and identify emerging issues.

To enable a more proactive operational monitoring process, this project extends conventional analytics into an AI-powered reporting workflow. Implemented using **n8n**, the workflow integrates operational KPIs, anomaly detection, customer voice analytics, and the **OpenAI API** to automatically generate executive-ready reports and deliver them directly to stakeholders.

**Workflow Architecture**

<img src="https://github.com/minhnguyen290304/Customer-Experience-Intelligence-From-Operational-Analytics-to-Intelligent-Automation/blob/main/workflows/Automation%20Workflow.png?raw=true" width="100%">

The workflow begins by retrieving operational datasets from Google Sheets, including Ticket records, SLA logs, and Customer Feedback. Ticket and SLA data are merged and processed through a series of business rules to calculate business-hour SLA, generate daily operational KPIs, and detect abnormal operational conditions such as declining SLA compliance, excessive handling delays, overloaded agents, or deteriorating service performance.

In parallel, customer feedback is filtered and aggregated before being combined with the operational KPIs. The consolidated analytical results are then transformed into structured prompts and passed to the **OpenAI API**, which generates AI-powered executive reports in HTML format. Finally, the reports are automatically delivered to stakeholders via Gmail, enabling daily operational monitoring without manual report preparation.

| Node | Purpose |
|------|---------|
| Schedule Trigger | Execute the workflow every morning |
| Google Sheets | Retrieve Ticket, SLA, and Customer Feedback datasets |
| Merge | Combine operational datasets |
| Business Logic | Calculate business-hour SLA and operational metrics |
| Daily KPI | Generate daily operational KPIs |
| Anomaly Detection | Identify abnormal operational conditions |
| OpenAI API | Generate AI-powered executive reports |
| Gmail | Automatically deliver reports to stakeholders |

### Automated Executive Reports

The workflow automatically generates two AI-powered reports designed for different operational scenarios.

#### Morning Brief

<img src="https://github.com/minhnguyen290304/Customer-Experience-Intelligence-From-Operational-Analytics-to-Intelligent-Automation/blob/main/visuals/Morning%20Brief%20Mail.png?raw=true" width="100%">

The Morning Brief is generated on a scheduled basis and provides management with a concise overview of daily operational performance. In addition to the executive summary shown above, the complete report includes:

- Executive Summary
- Daily KPI Summary
- Critical Alerts
- Agent Performance Highlights
- Agent Performance Highlights
- Customer Voice Summary
- Business Recommendation Action Plan

#### Critical Alert

<img src="https://github.com/minhnguyen290304/Customer-Experience-Intelligence-From-Operational-Analytics-to-Intelligent-Automation/blob/main/visuals/Critical%20Alert%20Mail.png?raw=true" width="100%">

Unlike the Morning Brief, the Critical Alert is generated only when predefined operational thresholds are exceeded. The report focuses exclusively on urgent operational risks and includes:

- Incident Summary
- Critical Alerts
- Affected Agents and Services
- Recommended Immediate Actions
- Executive Note

By integrating operational analytics, customer feedback analysis, anomaly detection, workflow automation, and Large Language Models into a single pipeline, the project transforms traditional dashboard-based monitoring into a proactive operational reporting system. Instead of manually reviewing dashboards each day, managers receive concise AI-generated executive reports directly in their inbox, enabling faster operational awareness and more timely decision-making.

---

# 7. Key Business Insights

### Insight 1: Growing Workload Is Putting Pressure on Service Performance

Customer support demand increased steadily throughout the reporting period, with more than 5,000 tickets processed over fourteen weeks. However, operational performance did not improve at the same pace. As ticket volume grew, the overall SLA On-Time Rate gradually declined, suggesting that operational capacity was unable to scale proportionally with customer demand. This indicates a growing pressure on Customer Experience operations that may eventually affect service quality if left unaddressed.

### Insight 2: Workload Distribution Across Agents Is Highly Imbalanced

The analysis reveals that customer support workload is concentrated among a small number of agents, while others handle significantly fewer tickets. Such imbalance increases dependency on key personnel, creates operational bottlenecks, and raises the likelihood of SLA violations. A more balanced workload allocation could improve both operational efficiency and service consistency.

### Insight 3: Operational Issues Are Concentrated Within Specific Services

Service-level analysis shows that poor SLA performance is not evenly distributed across all business services. Instead, a limited number of high-volume service categories consistently experience lower SLA compliance. Prioritizing operational improvements within these critical services would likely generate greater business impact than implementing organization-wide changes.

### Insight 4: Customer Feedback Complements Operational Metrics

Operational dashboards explain how Customer Support teams perform, while customer feedback explains why customers remain satisfied or dissatisfied. Topic Modeling identifies recurring concerns related to loan services, promotions, payments, account management, and application usability. Integrating these qualitative insights with operational KPIs provides a more complete understanding of customer experience and helps prioritize improvement initiatives.

### Insight 5: AI Enables Proactive Operational Decision-Making

Traditional dashboards require managers to manually review operational metrics before taking action. By integrating KPI monitoring, anomaly detection, customer feedback analysis, and Large Language Models into a single workflow, this project automatically generates executive Morning Briefs and Critical Alerts. The solution demonstrates how business intelligence can evolve into an AI-assisted decision support system that enables faster identification of operational risks while significantly reducing manual reporting effort.

---

# 8. Business Recommendations

### Recommendation 1: Improve Workload Allocation Across Support Agents

Implement workload balancing mechanisms that distribute tickets more evenly according to agent capacity, expertise, and historical performance. A more balanced allocation strategy can reduce operational bottlenecks while improving SLA compliance and overall service quality.

### Recommendation 2: Prioritize High-Impact Service Categories

Rather than allocating resources equally across all services, management should focus improvement efforts on service categories that combine high ticket volume with consistently poor SLA performance. Targeted optimization is likely to generate greater operational benefits while making more efficient use of available resources.

### Recommendation 3: Integrate Customer Voice Into Operational Monitoring

Customer feedback should become a regular component of operational performance evaluation instead of being reviewed separately. Combining Customer Voice Analytics with structured operational KPIs enables managers to better understand customer expectations, identify emerging issues earlier, and prioritize improvements based on real customer needs.

### Recommendation 4: Expand Intelligent Automation

The AI-powered workflow demonstrates that executive reporting can be generated automatically with minimal manual effort. Organizations should further extend intelligent automation into areas such as root cause analysis, predictive SLA monitoring, knowledge management, and operational decision support to enhance overall Customer Support management.

### Recommendation 5: Establish a Data-Driven CX Management Framework

Rather than relying solely on periodic dashboard reviews, organizations should integrate data engineering, operational analytics, customer feedback, and AI-assisted reporting into a unified Customer Support Intelligence framework. This approach enables continuous monitoring, faster response to operational risks, and more informed strategic decision-making.

---

# 9. Future Enhancements

### Real-Time Operational Monitoring

Replace scheduled batch processing with real-time data streaming to enable continuous monitoring of operational performance and faster detection of service disruptions.

### Predictive SLA Analytics

Develop machine learning models capable of forecasting SLA violations before they occur, allowing managers to proactively allocate resources and reduce potential service delays.

### Advanced Customer Voice Analytics

Enhance the current topic modeling approach with sentiment analysis, aspect-based sentiment analysis, or Retrieval-Augmented Generation (RAG) to generate richer customer insights and more context-aware recommendations.

### AI Operational Copilot

Extend the existing AI workflow into an interactive operational assistant capable of answering business questions, explaining KPI changes, identifying root causes, and recommending corrective actions through natural language conversations.

### Enterprise Data Integration

Integrate the solution with enterprise CRM, Customer Data Platform (CDP), ticketing systems, and data warehouses to support larger-scale deployments and enable organization-wide Customer Support Intelligence.


---

## Author

**Minh Nguyen** 🐧

---

## 📫 Connect With Me

- LinkedIn: https://www.linkedin.com/in/minhnguyen293/
- Email: minhnguyen29p304@gmail.com

---

⭐ Nothing is impossible
💫 Learn, learn more, learn forever
