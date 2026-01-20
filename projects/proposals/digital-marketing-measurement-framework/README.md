# 📊 Digital Marketing Measurement Framework Redesign

**Project Type:** Strategic Proposal (2020)  
**Industry:** Automotive (Hyundai/Genesis Dealer Network)  
**My Role:** Digital Strategy Lead & Analytics Framework Designer  
**Focus:** Attribution Modeling, ROI Measurement, Dynamic Budget Optimization

---

## 🎯 Executive Summary

This project proposed a comprehensive measurement framework transformation for an automotive dealer network's digital marketing operations.

**The Core Problem:**  
Traditional metrics (clicks, impressions, CPM) provided "inefficient numbers" that failed to answer the critical business question: _"What is the actual ROI of our media spend?"_

**My Solution:**  
I designed a data-driven strategy called **"The 6 SHIFTS"** that:

- Assigns monetary values to specific user actions (Action SHIFT)
- Implements multi-touch attribution to credit the full customer journey (Values SHIFT)
- Enables dynamic budget reallocation based on performance (Planning SHIFT)

**Expected Impact:**  
Transition from static budget execution to a flexible, ROI-optimized operation.

---

## 📉 The Challenge

The existing marketing operation suffered from three critical data gaps:

### 1. Metric Limitations

- Evaluation was difficult due to a focus on "Clicks, Impressions, CPM, CPC"
- No unified measurement for "Conversion/Action" or "ROI"

### 2. Static Budget Allocation

- Media budgets were separated by channel, preventing flexible optimization
- Budgets were fixed via "Initial IO" rather than responding to weekly performance data

### 3. Attribution Bias

- The system relied on "Last Click" measurement only
- Failed to value the "Assisted Conversion Value" of upper-funnel channels (Display, Social)

---

## 🔬 Proposed Solution: "The 6 SHIFTS"

### SHIFT 1: Action Valuation

**Assign dollar values to every user action to calculate total ROI.**

Instead of tracking only final sales, I proposed tracking **all user actions** and assigning a monetary value to each based on downstream conversion probability.

![Action Valuation Model](assets/action-valuation-model.png)

| User Action          | Traditional Metric | Assigned Value ($) |
| :------------------- | :----------------- | :----------------- |
| Form Submission      | Conversion         | **$1,200**         |
| Brochure Download    | Hit/Click          | **$120**           |
| Video View (100%)    | View               | **$115**           |
| Video View (50%)     | View               | **$80**            |
| Dealer Locator Click | Click              | **$450**           |
| Scroll Depth (75%+)  | Interaction        | **$40**            |

**Impact:** Enables calculation of ROI for all user activities on the website, not just final conversions.

---

### SHIFT 2: Attribution Modeling

**Credit all touchpoints, not just the last click.**

I introduced **Assisted Conversions** and **Assisted Conversion Value** metrics to measure the true contribution of channels like Display and Social, which build awareness but often don't receive final-click credit.

![Attribution Comparison](assets/attribution-comparison.png)

#### Real Data Insight:

Display Advertising often appears inefficient in Last-Click models. However, analysis of actual campaign data revealed its hidden value:

```
Channel: Display Ads
├─ Last-Click Conversion Value:  $30.00
├─ Assisted Conversion Value:    $170.00
└─ Insight: Assisted value is 5.6x higher than direct value

Interpretation:
- Display builds awareness that drives conversions through other channels
- Cutting display budget would damage overall conversion performance
- Display should be evaluated on total contribution, not just last-click
```

**Key Metrics Introduced:**

- **Last-Click Conversion Value** → Shows "closers"
- **Assisted Conversion Value** → Shows "supporters"
- **Assist Ratio** → Reveals true channel role in customer journey

---

### SHIFT 3: Dynamic Budget Optimization

**Weekly performance-based budget reallocation.**

Moving away from fixed "Initial IO Budgets" to a flexible model where budget flows to high-performing media based on ROAS evaluation.

![Dynamic Budget Allocation](assets/dynamic-budget-allocation.png)

#### Optimization Logic:

```
Evaluation Cycle: Weekly or Bi-weekly
Method: Re-allocate based on Conversion Rate, ROI, and ROAS

Example Scenario:
Initial Budget (Week 1):
├─ Media A: $10K → ROAS 1.2x
├─ Media B: $10K → ROAS 2.8x
├─ Media C: $10K → ROAS 0.8x
└─ Media D: $10K → ROAS 3.1x

Optimized Allocation (Week 3):
├─ Media A: $7.5K (-25%)  — Below target, reduce
├─ Media B: $13K (+30%)   — High performer, increase
├─ Media C: $5K (-50%)    — Losing money, cut significantly
└─ Media D: $14.5K (+45%) — Top performer, maximize

Result: Same total budget, projected +32% ROAS improvement
```

**Key Benefits:**

- Efficient budget allocation through quick response to performance
- Ability to calculate projected ad budget for optimal ROI
- Continuous optimization vs. "set and forget"

---

### SHIFT 4: Audience Segmentation

**Leverage 1st + 3rd party data for quality targeting.**

#### Data Layer Integration:

**1st Party Data:**

- Website behavioral patterns (pages viewed, time on site)
- CRM data (previous customers, inquiry status)
- Email engagement metrics

**3rd Party DMPs:**

- **Oracle Data Cloud (BlueKai):** Auto in-market shoppers
- **LiveRamp, eXelate:** Purchase intent signals, competitor affinities
- **Eyeota/Experian:** Vehicle category interest, lifestyle data

![Audience Segmentation Performance](assets/audience-segmentation.png)

#### Performance Evidence:

Analysis of Genesis programmatic campaigns (March 2020) showed:

| Targeting Strategy            | Conversion Performance             |
| :---------------------------- | :--------------------------------- |
| **In-Market Audience**        | **+285% vs. remarketing baseline** |
| **3rd-Party DMP Integration** | **+120% vs. 1st-party only**       |
| Remarketing (control)         | Baseline (100%)                    |

---

### SHIFT 5: Search Intelligence

**AI-driven paid search optimization.**

#### Key Tactics:

- **Responsive Search Ads (RSA):** Auto-tests multiple headline/description combinations
- **Dynamic Search Ads (DSA):** Auto-generates ads from website content (ideal for large inventory)
- **Data-Driven Attribution:** Assigns appropriate value to keywords based on full funnel contribution

#### Performance Benchmark:

Analysis of Genesis paid search campaigns (March 2020):

```
Paid Search Conversion Rate:  51.27%
All Channels Average:          20.73%

Performance: 2.5x above average
```

**Strategic Implication:** Search's proven high-intent performance justified 35-40% of total digital budget allocation.

---

### SHIFT 6: Dealer Support Program

**Co-op program providing dealers enterprise-grade targeting at zero cost.**

#### What Dealers Receive (Free):

- Professional display creative (auto-generated with dealer info, phone, address)
- Access to centralized high-quality audience data (1st + 3rd party)
- Optimized targeting settings (location radius, business hours scheduling)

#### What HMA Gains:

- Increased local inventory visibility across markets
- Dealer loyalty through value-added services
- Aggregated performance data for brand insights

**Cost Structure:** Dealers pay only media spend; HMA absorbs platform fees, data costs, and creative production.

---

## 📊 Key Metrics Framework

| Category         | Traditional Metrics (As-Is) | Proposed Advanced Metrics (To-Be)          |
| :--------------- | :-------------------------- | :----------------------------------------- |
| **Volume**       | Impressions, Clicks         | **Total Conversion Value ($)**             |
| **Efficiency**   | CPM, CPC, CTR               | **ROAS, ROI, Cost per Conversion Value**   |
| **Attribution**  | Last-click only             | **Assisted Conversion Ratio, Multi-Touch** |
| **Optimization** | Fixed quarterly budget      | **Dynamic Allocation Rate (% change)**     |

---

## 🛠️ Technical Stack

**Note:** The original proposal (2020) referenced Universal Analytics. Below is the modern equivalent implementation:

| Category          | Tools & Platforms                                         |
| :---------------- | :-------------------------------------------------------- |
| **Analytics**     | Google Analytics 4 (GA4), BigQuery                        |
| **Advertising**   | Google Ads, Display & Video 360 (DV360)                   |
| **Data Sources**  | 1st Party CRM Data, Oracle Data Cloud (BlueKai), LiveRamp |
| **Visualization** | Looker Studio (formerly Data Studio)                      |
| **Automation**    | Google Apps Script, Python                                |

---

## 📁 Project Status & Context

**Status:** Proposal Phase (Strategic Framework)

**Why This Wasn't Executed:**  
This comprehensive proposal was developed in **April 2020**. Due to the onset of the COVID-19 pandemic and subsequent economic uncertainty in the automotive industry (dealership closures, sales plummeting 40%+), the client froze all new marketing initiatives.

**Portfolio Value:**  
While not implemented, this project demonstrates:

✅ **Framework Design:** Architecting complex measurement systems from scratch  
✅ **Business Translation:** Converting abstract goals into concrete tracking taxonomies  
✅ **Strategic Optimization:** Using data to drive operational efficiency (20-30% improvement potential)  
✅ **Stakeholder Communication:** Creating executive-ready proposals with clear ROI projections

---

## 📂 Repository Contents

```
digital-marketing-measurement-framework/
├── README.md
├── assets/
│   └── images/
│       ├── action-valuation-model.png
│       ├── attribution-comparison.png
│       ├── dynamic-budget-allocation.png
│       └── audience-segmentation.png
└── LEARNINGS.md
```

---

## 🔗 Related Work

- **[Executed Campaign Portfolio](../)** — See actual campaigns with measured results
- **[Analytics Dashboards](../dashboards/)** — Measurement frameworks I've built
- **[Main Portfolio](../../README.md)** — Full body of work

---

## 📬 Connect

Questions about this framework or similar measurement challenges?

📧 [your.email@example.com]  
💼 [LinkedIn Profile]  
🌐 [Portfolio Website]

---

<div align="center">

_This proposal represents strategic thinking and analytical framework design capabilities._  
_For executed campaigns with measured results, see my [main portfolio](../../README.md)._

</div>
```
