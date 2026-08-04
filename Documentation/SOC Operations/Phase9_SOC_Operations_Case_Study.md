# VioletOps Phase 9 — SOC Operations and Investigation Case Study

## Case Study Status

Technically validated, sanitized, and approved for portfolio review.

## Executive Summary

This case study documents a simulated Tier 1 SOC shift in the VioletOps cybersecurity lab.

The shift included:

- Telemetry readiness validation
- Alert review and triage
- Two investigation cases
- Cross-platform evidence correlation
- Severity and disposition decisions
- Escalation and containment review
- Shift handoff reporting
- Operational metrics and improvement recommendations

Twenty-one Wazuh alerts were reviewed across two cases. Both cases were closed as false positives after correlating Wazuh, Splunk, Sysmon, PowerShell, process, parent-process, service-context, signature, hash, and network evidence.

No malicious activity was confirmed. No escalation, containment, recovery, or permanent configuration change was required.

## Sanitization Notice

This public case study excludes:

- Internal IP addresses
- Personal and administrative usernames
- Physical host names
- Private domain information
- Sensitive internal file paths
- Credentials, tokens, and secrets
- Unsanitized screenshots
- Internal-only evidence manifests and working records

Relevant alert, event, process, and correlation timestamps were preserved where they support the investigation timeline.

## SOC Shift Objectives

The Phase 9 objectives were to demonstrate whether a Tier 1 SOC analyst could:

- Confirm telemetry availability before beginning a shift
- Review and prioritize security alerts
- Select appropriate investigation cases
- Correlate evidence across multiple security platforms
- Distinguish malicious activity from false positives
- Record severity, confidence, and disposition
- Make justified escalation and containment decisions
- Produce a clear next-shift handoff
- Record operational metrics and limitations

## Tools and Telemetry

The investigation used:

- Wazuh alerting and endpoint visibility
- Splunk Enterprise search and correlation
- Windows Sysmon process and network events
- Windows PowerShell Operational logs
- Endpoint process, service, signature, and hash verification
- Firewall and network evidence when available

Standard Splunk Enterprise was used for search and telemetry correlation. A dedicated case-management platform was not present in the current lab.

## Shift Readiness and Alert Queue

The analyst confirmed that the required telemetry sources were available before beginning investigation work.

The reviewed queue included Windows Security, PowerShell Operational, and Sysmon Operational telemetry. Wazuh dashboard availability and agent visibility were also confirmed.

The Phase 9 portfolio retains a sanitized Splunk telemetry-queue screenshot showing the available sources, event counts, and latest-event timestamps.

## Alert Review Summary

| Detection | Original Severity | Alerts Reviewed | Final Severity | Final Disposition |
|---|---:|---:|---:|---|
| Wazuh Rule 91823 | Level 14 | 4 | Low | False positive |
| Wazuh Rule 92058 | Level 12 | 17 | Low | False positive |

### Shift Totals

- Total alerts reviewed: 21
- Cases investigated: 2
- Confirmed malicious alerts: 0
- False-positive alerts: 21
- Cases escalated: 0
- Containment actions performed: 0
- Recovery actions performed: 0
- Active incidents at handoff: 0

## Investigation Case 1 — Rule 91823

### Triggering Alert

Wazuh Rule 91823 generated four Level 14 alerts describing possible PowerShell Invoke-Command remote execution.

The alert text was treated as high priority because remote PowerShell execution can indicate lateral movement, administrative misuse, or unauthorized remote access.

### Evidence Reviewed

The analyst reviewed:

- Wazuh Rule 91823 alert details
- PowerShell Event ID 4104 script-block evidence
- Sysmon process-creation events
- Parent and child process relationships
- Process command lines
- Related network-connection evidence
- Splunk telemetry covering the investigation window

### Correlation Findings

The PowerShell events contained the built-in Invoke-Command proxy-function definition. The available process evidence linked the activity to legitimate Windows diagnostic processes.

The confirmed process chain included a Windows service process launching a diagnostic host process. No remote target, executed remote command, or supporting network connection was identified.

Older supporting evidence was not fully retained for one portion of the activity, so the analyst preserved a reduced-confidence limitation for that older evidence.

### Case 1 Decision

- Final severity: Low
- Disposition: False positive — benign Windows diagnostic activity
- Confidence: High for the fully correlated activity
- Confidence limitation: Moderate for older activity with reduced retained evidence
- Escalation required: No
- Containment required: No
- Recommended action: Retain evidence and evaluate detection tuning only if the same verified benign pattern repeats

## Investigation Case 2 — Rule 92058

### Triggering Alert

Wazuh Rule 92058 generated seventeen Level 12 alerts for Windows Application Compatibility Database activity.

The detection mapped the activity to MITRE ATT&CK technique T1546.011, Application Shimming. This technique can be abused for persistence, so the alert required investigation even though the observed utility was a legitimate Windows component.

### Evidence Reviewed

The analyst reviewed:

- Wazuh Rule 92058 alert details
- Sysmon Event ID 1 process creation
- Process and parent-process information
- Service context
- User context
- Endpoint file signature
- Endpoint SHA-256
- Matching Splunk event and file hash
- Related network evidence

### Correlation Findings

The compatibility utility was Microsoft-signed and launched by a legitimate Windows service process under the Program Compatibility Assistant service context.

The endpoint SHA-256 matched the value recorded in Splunk. No malicious compatibility database, persistence behavior, suspicious parent process, or related network activity was confirmed.

The exact compatibility-database file and its contents were not captured, so that evidence limitation was preserved in the case record.

### Case 2 Decision

- Final severity: Low
- Disposition: False positive — benign Windows application-compatibility activity
- Confidence: High
- Escalation required: No
- Containment required: No
- Recommended action: Retain evidence and evaluate detection tuning if the same verified service pattern repeatedly generates alerts

## Escalation and Response Decisions

Neither case met escalation criteria.

The evidence did not confirm:

- Unauthorized remote execution
- Credential misuse
- Suspicious persistence
- Malicious process ancestry
- Unsigned or mismatched binaries
- Command-and-control activity
- Unauthorized network destinations
- Continuing malicious behavior

No host isolation, account disablement, process termination, file quarantine, firewall change, service interruption, recovery action, or rule modification was performed.

Containment without confirmed malicious activity could have interrupted legitimate Windows services.

## Shift Handoff

A sanitized SOC shift-handoff report was created as a separate portfolio artifact.

The handoff includes:

- Completed shift activities
- Alert totals and dispositions
- Case 1 and Case 2 summaries
- Monitoring and evidence gaps
- Recommended next-shift actions
- Escalation and containment status
- Environment and configuration-change status

## Operational Metrics

### Investigation Durations

| Case | Documented Duration |
|---|---:|
| P9-CASE-01 | 7 minutes |
| P9-CASE-02 | 27 minutes |

- Total investigation time: 34 minutes
- Average investigation time: 17 minutes
- Minimum investigation time: 7 minutes
- Maximum investigation time: 27 minutes

These values represent documented case-open to case-close time.

Mean time to detect, alert-generation-to-triage time, and analyst acknowledgement time were not calculated because the required timestamps were not consistently captured for both cases.

## Operational Limitations

- Some older process and network evidence was no longer retained.
- Splunk did not expose every PowerShell Event Record ID referenced by Wazuh.
- The specific compatibility-database file and its contents were not captured.
- Standard Splunk Enterprise does not provide the full SOC case-management workflow available in Splunk Enterprise Security.
- The lab does not yet include a dedicated case platform such as TheHive, Jira, or ServiceNow.
- The metrics represent a two-case lab sample and are not production SOC benchmarks.

## Improvement Opportunities

- Extend process and network telemetry retention.
- Normalize Wazuh and Splunk fields for easier cross-platform correlation.
- Capture alert creation, acknowledgement, investigation start, and closure timestamps.
- Review repeated verified benign Rule 91823 and Rule 92058 patterns for possible tuning.
- Add a dedicated SOC case-management platform.
- Automate alert-to-case creation when controlled attack automation is added.
- Preserve direct links between alerts, evidence, analyst decisions, and final dispositions.

## Configuration Impact

Phase 9 required no permanent infrastructure change.

No changes were made to:

- Network architecture
- Virtual-machine inventory
- IP addressing
- Firewall rules or ports
- Services or scheduled tasks
- Logging policy
- Endpoint or SIEM configuration

## Portfolio Evidence

The public Phase 9 evidence set includes six sanitized screenshots:

- Splunk telemetry queue
- Rule 91823 process correlation
- Case 1 alert and telemetry correlation
- Rule 92058 alert details
- Case 2 process and parent-process details
- Case 2 Splunk correlation

A sanitized SHA-256 manifest is included with the public files.

## Interview Talking Points

- I reviewed and triaged 21 alerts across two SOC investigation cases.
- I correlated Wazuh, Splunk, Sysmon, PowerShell, process, service, signature, hash, and network evidence.
- I reduced two high-severity alert groups to Low severity only after validating the evidence.
- I documented confidence limitations instead of overstating certainty.
- I explained why escalation and containment were not justified.
- I created a realistic next-shift handoff and operational review.
- I preserved raw evidence internally and published only sanitized portfolio copies.
- I identified case-management and telemetry-retention improvements for future lab development.

## Conclusion

Phase 9 demonstrated a complete Tier 1 SOC workflow from readiness validation through alert review, investigation, response decision-making, handoff, metrics, and portfolio documentation.

Both investigation cases were closed as false positives based on correlated evidence. The work preserved important limitations, avoided unnecessary containment, and produced sanitized documentation suitable for SOC analyst interview discussion.
