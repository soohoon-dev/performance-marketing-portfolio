# Share Stage Templates (Copy/Paste)

이 파일은 BigQuery 결과를 **Markdown 표**로 정리해서 `docs/case_study.md`에 붙여넣기 쉽게 만든 템플릿입니다.

---

## 1) Analyze — Overall KPIs (완성본; `sql/03_kpi_queries.sql` Section A)

| metric_name | metric_value | notes |
|---|---:|---|
| kpi.total_reads | 3000 | All rows in v_fact_reading_logs |
| kpi.completed_reads | 1605 | Rows where is_completed=TRUE |
| kpi.completion_rate | 0.535 | completed_reads / total_reads |
| kpi.completed_with_action | 594 | is_completed=TRUE AND action_performed=TRUE |
| kpi.action_rate_completed_only | 0.37009345794392523 | completed_with_action / completed_reads |

---

## 2) Analyze — Reminder Opt-in vs Action Rate (completed-only; `sql/03` Section B)

| reminder_opt_in | completed_reads | completed_with_action | action_rate_completed_only |
|---:|---:|---:|---:|
| false | 774 | 220 | 0.2842377260981912 |
| true | 831 | 374 | 0.45006016847172081 |

---

## 3) Analyze — Time to Verification (days; `sql/03` Section E)

| verified_actions | avg_days_to_verification | days_to_verification_quantiles |
|---:|---:|---|
| 594 | 6.163299663299668 | [1, 2, 4, 7, 10, 32] |

해석 가이드(간단):
- 분위수는 (min, p20, p40, p60, p80, max) 형태로 이해하면 됩니다.
- 여기서는 “대부분은 1~10일 사이, 최댓값 32일” 같은 메시지로 요약 가능.

---

## 4) (선택) Analyze — Book attributes vs Action Rate (요약용)
Section C는 행이 많아 표 전체를 붙이기보다, 아래처럼 “Top finding”만 요약하는 것을 추천합니다.

예시 관찰(표본이 작은 그룹은 해석 주의):
- has_action_guide=TRUE인 조합에서 action_rate가 상대적으로 높은 조합들이 다수 존재
- 예: MARKETING difficulty=1, has_action_guide=TRUE → action_rate ≈ 0.73 (completed_reads=41)

---

## 5) (선택) Analyze — Segments vs Completion Rate (요약용)
Section D도 전체 표를 붙이기보다, completion_rate가 높은/낮은 상위 몇 개만 요약해도 충분합니다.

예시:
- Paid Ads / Pro / Freelancer → completion_rate = 0.68 (n=25)
- Referral / Pro / Student → completion_rate = 0.3125 (n=16)

표본이 작으면(예: n<30) “추가 데이터 필요” 코멘트를 넣는 것이 좋습니다.