# MITRE ATT&CK Mapping

## Detection Scenario

Repeated failed Windows logons associated with Security Event ID 4625.

## Primary Mapping

- Tactic: Credential Access
- Technique: Brute Force
- Technique ID: T1110

## Why This Mapping Applies

Repeated failed logons may indicate an attempt to guess, reuse, or validate credentials. The workflow treats these events as potential brute-force or password-spraying activity and adds the mapping during automated enrichment.

## Workflow Use

The MITRE ATT&CK mapping is included in the enriched alert and carried forward into the analyst investigation context.

It helps the analyst:

- Classify the activity
- Understand the likely adversary behavior
- Prioritize investigation
- Connect the alert to related detections
- Document the incident consistently

## Analyst Validation

The mapping is contextual and does not prove malicious activity by itself.

The analyst should also review:

- Failed-logon frequency
- Targeted accounts
- Source address
- Related lockout events
- Privileged-account involvement
- Approved testing activity
- Signs of password spraying or credential abuse

## Safety Note

The mapping supports investigation and prioritization only. It does not trigger automatic destructive containment.
