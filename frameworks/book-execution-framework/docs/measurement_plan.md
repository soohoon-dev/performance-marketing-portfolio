# Measurement Plan (MVP) — Book Execution Framework

This measurement plan defines **what we track**, **why it matters**, and **how to validate** analytics for the Book Execution Framework MVP.

**North Star intent:** reduce the _Knowledge → Action_ gap by nudging users to complete an execution frame immediately after reading.  
**Tracking stack:** GTM → GA4  
**Primary conversion (Key event):** `frame_save`

---

## 1) Product Questions (What we want to learn)

1. **Activation:** Do users actually start interacting with the form after landing?
2. **Engagement entry point:** Which fields do users start with (where attention goes first)?
3. **Friction:** What prevents completion (validation errors, missing required input)?
4. **Retention intent:** Which follow-up option do users choose (e.g., export)?
5. **Completion:** What share of starters successfully save the frame?

---

## 2) Funnel Definition (MVP)

### Core funnel

1. **Start** → `frame_start`
2. **Complete** → `frame_save` _(Key event)_

### Supporting signals

- **Friction / UX issues** → `form_error`
- **Retention intent** → `opt_in_click`

---

## 3) Naming Conventions & Data Quality Rules

### Event naming

- Use `snake_case` (e.g., `frame_save`, `form_error`)
- Keep event names stable across iterations (avoid renaming after data exists)

### Parameter naming

- Use `snake_case` (e.g., `input_length_total`)
- Prefer stable **codes** over long natural language for errors (e.g., `empty_value`)

---

## 4) Event Spec (Dictionary)

## 4.1 `frame_start`

**Product meaning:** User shows intent by focusing a form field (start of interaction).

**Frontend trigger:**

- Called on focus: `trackFocus(fieldName)`
- Emits: `dataLayer.push({ event: 'frame_start', field_name: <string> })`

### Parameters

| Parameter    | Type   | Required |          Example | Notes                              |
| ------------ | ------ | :------: | ---------------: | ---------------------------------- |
| `field_name` | string |    ✅    | `"reflection_3"` | Identifies which field was focused |

### Allowed values (`field_name`)

Use one of the following identifiers (keep consistent to avoid messy reports):

- `skill`
- `weakness`
- `practice`
- `reflection1`
- `reflection2`
- `reflection3`

### Key metrics

- **Start rate:** sessions with ≥ 1 `frame_start`
- **Top entry fields:** distribution of `field_name`
- **Field drop-off hint:** compare `frame_start` volume vs `frame_save`

---

## 4.2 `opt_in_click`

**Product meaning:** User indicates follow-up intent (retention signal) by selecting an opt-in option.

**Frontend trigger:**

- Called on checkbox change: `trackOptIn(type)`
- Emits (only when checked): `dataLayer.push({ event: 'opt_in_click', opt_in_type: <string> })`

### Parameters

| Parameter     | Type   | Required |    Example | Notes                          |
| ------------- | ------ | :------: | ---------: | ------------------------------ |
| `opt_in_type` | string |    ✅    | `"export"` | Which opt-in the user selected |

### Key metrics

- **Opt-in rate:** sessions with `opt_in_click`
- **Opt-in preference:** distribution of `opt_in_type`

---

## 4.3 `form_error`

**Product meaning:** User attempted to save but got blocked by validation (friction / UX issue).

**Frontend trigger:**

- On Save when invalid:  
  `dataLayer.push({ event: 'form_error', error_field: <string>, error_message: <string> })`

### Parameters

| Parameter       | Type   | Required |         Example | Notes                                     |
| --------------- | ------ | :------: | --------------: | ----------------------------------------- |
| `error_field`   | string |    ✅    |       `"skill"` | Which field caused the validation failure |
| `error_message` | string |    ✅    | `"empty_value"` | Stable error code for reporting           |

### Recommended allowed values

- `error_field`: `skill`, `weakness`, `practice`, `reflection1`, `reflection2`, `reflection3`
- `error_message`: `empty_value` _(extend later as needed: `too_short`, `invalid_format`, etc.)_

### Key metrics

- **Error rate:** sessions with `form_error`
- **Top blockers:** `error_field` frequency
- **Fix impact:** does error rate drop after UX copy/validation changes?

---

## 4.4 `frame_save` (Key event)

**Product meaning:** User successfully completed and saved the execution frame (primary conversion).

**Frontend trigger:**

- On Save success:  
  `dataLayer.push({ event: 'frame_save', book_id: 'BK-001', input_length_total: <number> })`

### Parameters

| Parameter            | Type   | Required |    Example | Notes                                    |
| -------------------- | ------ | :------: | ---------: | ---------------------------------------- |
| `book_id`            | string |    ✅    | `"BK-001"` | Identifies the book/template used        |
| `input_length_total` | number |    ✅    |       `58` | Simple proxy for content volume / effort |

### Key metrics

- **Save rate:** `frame_save` / sessions
- **Completion rate:** `frame_save` / starters (sessions with `frame_start`)
- **Avg content volume:** average `input_length_total` on `frame_save`

---

## 5) Analytics Implementation (How it is wired)

### GTM

- Triggers: Custom Event (`CE - frame_start`, `CE - opt_in_click`, `CE - form_error`, `CE - frame_save`)
- Tags: GA4 Event tags using the same event names
- Variables: Data Layer Variables (e.g., `dlv - field_name`) mapped to GA4 event parameters

### GA4

- Events validated in **DebugView**
- `frame_save` marked as a **Key event**

---

## 6) QA Checklist (before/after releases)

### GTM QA (Preview mode)

- [ ] Each custom event appears in the GTM event stream
- [ ] Each GA4 event tag fires successfully on the correct trigger
- [ ] Parameters resolve correctly (non-empty values where expected)

### GA4 QA (DebugView)

- [ ] `frame_start` includes `field_name`
- [ ] `opt_in_click` includes `opt_in_type`
- [ ] `form_error` includes `error_field` and `error_message`
- [ ] `frame_save` includes `book_id` and `input_length_total`

---

## 7) Known Limitations (MVP)

- No backend identity → analysis is session/device-based
- `input_length_total` is a proxy metric (not semantic quality)
- DebugView is for validation; standard reports can take time to populate

---

## 8) Future Extensions (optional)

If the MVP expands, consider adding consistent context parameters:

- `category` (e.g., Business)
- `frame_version` (to compare iterations)
- `experiment_variant` (A/B testing)
- `frame_id` (to track multiple saved frames)
