# SOAR-Style Failed-Logon Response Playbook

## Purpose

This playbook documents a safe, analyst-controlled response process for repeated failed Windows logons associated with Security Event ID 4625.

## Trigger

The workflow starts when a controlled failed-logon alert contains:

- Timestamp
- Host
- Account
- Event ID
- Source address
- Detection name
- Severity

## Automated Workflow Stages

1. Normalize the alert into a consistent schema.
2. Enrich the alert with host, account, frequency, related-event, MITRE ATT&CK, and risk context.
3. Calculate a deterministic risk score and risk level.
4. Generate an incident summary and recommended response.
5. Append a structured audit entry.

## Decision Logic

The workflow evaluates:

- Alert severity
- Failed-logon frequency
- Related security events
- Account context
- Host context
- Known test conditions

The workflow returns:

- Risk score
- Risk level
- Response recommendation
- Analyst approval requirement
- Automatic-containment status

## Safe Automated Actions

The workflow may automatically:

- Create normalized JSON
- Create enriched JSON
- Create decision JSON
- Create an incident summary
- Append an audit-log entry
- Recommend investigation and containment steps

## Analyst Approval Required

The workflow does not automatically:

- Disable accounts
- Reset passwords
- Isolate hosts
- Add firewall blocks
- Modify Active Directory
- Delete evidence
- Stop services
- Terminate processes

These actions require analyst review and explicit approval.

## Analyst Investigation Steps

1. Confirm the alert fields are complete.
2. Review the failed-logon frequency and timeframe.
3. Validate whether the source address is expected.
4. Review related authentication and account-lockout events.
5. Check whether the activity is part of an approved test.
6. Determine whether the account or host shows signs of compromise.
7. Approve or reject the recommended response.

## Escalation Criteria

Escalate when:

- Failed logons continue after user validation.
- The account is privileged or sensitive.
- Related suspicious events are present.
- Multiple hosts or accounts are targeted.
- The source address is unexpected.
- Evidence suggests credential abuse or password spraying.

## Containment Guidance

After analyst approval, possible containment actions include:

- Disable or lock the affected account.
- Reset credentials.
- Isolate the affected host.
- Block the confirmed malicious source.
- Preserve relevant evidence.
- Escalate to incident response.

## Audit Requirements

Each workflow run should record:

- Run ID
- Alert ID
- Timestamp
- Risk score
- Risk level
- Response status
- Analyst-approval requirement
- Automatic-containment status
- Workflow status

## Safety Control

Automatic destructive containment remains disabled. The workflow is designed to support analyst decision-making, not replace analyst authorization.
