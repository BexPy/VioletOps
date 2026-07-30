# VioletOps Phase 7 Case Study
## Automated Failed-Logon Investigation and SOAR-Style Response Workflow

## Objective

Build a reusable PowerShell workflow that processes a controlled Windows Security Event ID 4625 alert, enriches it, assigns a deterministic risk score, recommends a response, and records an audit trail.

## Security Problem

Repeated failed Windows logons can indicate:

- User error
- Stale saved credentials
- Misconfigured scheduled tasks
- Password spraying
- Credential abuse
- Unauthorized administrative activity

Manual review can be slow and inconsistent. This project automates the repeatable investigation steps while preserving analyst control over destructive actions.

## Workflow Design

The workflow contains five stages:

1. Alert normalization
2. Automated enrichment
3. Risk scoring and decision logic
4. Incident-summary and response generation
5. Audit logging

## Normalized Alert Fields

The workflow converts the input into a consistent schema containing:

- Schema version
- Alert ID
- Timestamp
- Host
- Account
- Event ID
- Source address
- Detection name
- Severity

## Automated Enrichment

The workflow adds:

- Host context
- Account context
- Event frequency
- Related-event context
- MITRE ATT&CK mapping
- Risk-scoring inputs
- Failure-reporting status

## Decision Logic

The workflow assigns a deterministic risk score using alert severity, frequency, account context, host context, and related events.

The decision output includes:

- Risk score
- Risk level
- Response recommendation
- Analyst-approval requirement
- Automatic-containment status

## Safe Response Model

The workflow automatically creates:

- Normalized JSON
- Enriched JSON
- Decision JSON
- Incident-summary JSON
- JSONL audit records
- Readable analyst console output

The workflow does not automatically:

- Disable accounts
- Reset passwords
- Isolate hosts
- Add firewall blocks
- Modify Active Directory
- Delete evidence
- Stop services
- Terminate processes

These actions remain analyst-approved.

## Technical Validation

The reusable workflow was validated with:

- PowerShell parser checks
- Controlled successful execution
- Required-output validation
- Missing-field failure testing
- Empty-output failure testing
- Repeatability testing
- Sensitive-value scanning
- SHA-256 file hashing

The sanitized public workflow completed successfully with:

- Workflow Status: Success
- Risk Score: 40
- Risk Level: Medium
- Response Status: Recommended
- Analyst Approval Required: True
- Automatic Containment Executed: False
- Launcher Exit Code: 0

## MITRE ATT&CK Mapping

The workflow maps repeated failed-logon activity to:

- Tactic: Credential Access
- Technique: Brute Force
- Technique ID: T1110

## Portfolio Evidence

Approved screenshots demonstrate:

- Normalized alert output
- Automated enrichment
- Risk scoring and decision logic
- Incident summary and audit trail
- Readable analyst-facing summary

## SOC Analyst Relevance

This project demonstrates:

- Alert normalization
- Security-event enrichment
- Detection-to-response automation
- Risk-based decision logic
- Safe SOAR-style orchestration
- Analyst approval controls
- Structured incident documentation
- Auditability
- Error handling
- Repeatable testing
- Public-data sanitization

## Limitations and Future Improvements

Current limitations:

- The workflow uses controlled JSON input rather than direct ingestion from a live SIEM alert.
- Risk scoring is deterministic and based on a limited set of predefined conditions.
- Host, account, and event-frequency context is simulated for safe portfolio validation.
- The workflow recommends containment but does not connect to Active Directory, endpoint-isolation, or firewall APIs.
- Analyst approval is represented as a required decision point rather than an integrated approval platform.
- The workflow focuses on Windows Security Event ID 4625 and does not yet correlate multiple detection sources.

Future improvements:

- Integrate direct alert ingestion from Splunk or another SIEM.
- Add configurable risk thresholds and scoring rules.
- Correlate Event IDs 4625, 4740, and related endpoint or firewall events.
- Add approved threat-intelligence enrichment.
- Integrate a ticketing or case-management platform.
- Add authenticated analyst approval before containment actions.
- Add unit tests and automated regression testing.
- Support additional authentication and endpoint detection scenarios.

## Interview Talking Points

- I built a reusable PowerShell workflow that processes failed-logon alerts through normalization, enrichment, decision logic, response recommendation, and audit logging.
- I used deterministic risk scoring so the same input produces consistent and explainable decisions.
- I kept destructive containment disabled and required analyst approval for account, endpoint, firewall, and Active Directory changes.
- I tested both successful and failure paths, including missing fields, missing outputs, and repeated workflow runs.
- I created structured JSON and JSONL outputs so an analyst can review, automate, and audit each stage.
- I sanitized the public release and scanned it for internal infrastructure values before committing it.
- The project demonstrates SOAR-style orchestration without pretending that a script should replace analyst judgment.
- A future production version could ingest SIEM alerts directly and connect to approved response APIs with authenticated approval controls.
## Outcome

The project produced a reusable and portable PowerShell-based security automation workflow. It reduces repetitive analyst work while keeping high-impact containment decisions under human control.
