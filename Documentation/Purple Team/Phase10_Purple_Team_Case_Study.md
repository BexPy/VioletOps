# VioletOps Phase 10 - Purple Team Detection Validation and Improvement Case Study

## Case Study Status

Technically validated, sanitized, and prepared for final repository review. Final public approval remains pending Section 12 repository review and Git validation.

## Executive Summary

This case study documents a controlled purple-team exercise performed in the VioletOps cybersecurity lab.

The exercise combined controlled adversary emulation, defensive telemetry review, detection-gap analysis, detection engineering, retesting, and operational validation.

Two MITRE ATT&CK discovery techniques were evaluated:

- T1046 - Network Service Discovery
- T1018 - Remote System Discovery

The initial assessment identified incomplete direct detection coverage. T1046 activity produced usable endpoint and SIEM telemetry but lacked a direct technique-specific Splunk detection. T1018 activity successfully reached the target but did not initially produce usable defensive telemetry.

Detection improvements were then implemented and retested.

Final validated results:

- Direct technique-specific Splunk coverage improved from 0 of 2 scenarios (0%) to 2 of 2 scenarios (100%).
- Direct usable defensive telemetry coverage improved from 1 of 2 scenarios (50%) to 2 of 2 scenarios (100%).
- Both improved detections were validated against controlled retest activity.
- Cleanup and post-test endpoint, Splunk, and Wazuh health checks passed.

No exploitation, credential access, privilege escalation, persistence, malware execution, destructive activity, or service disruption was performed.

## Sanitization Notice

This public case study excludes:

- Internal IP addresses
- Personal and administrative usernames
- Physical host names
- Private domain information
- Sensitive internal file paths
- Credentials, tokens, and secrets
- Raw unsanitized screenshots
- Internal-only evidence records

Public evidence uses sanitized host labels and approved portfolio screenshots.

## Purple Team Objectives

The Phase 10 objectives were to demonstrate whether a SOC analyst could:

- Establish a safe and authorized purple-team test scope
- Validate baseline endpoint and SIEM telemetry
- Execute controlled ATT&CK-mapped discovery techniques
- Correlate endpoint, Splunk, and Wazuh evidence
- Identify missing or incomplete telemetry
- Identify weak, missed, or incorrectly classified detections
- Prioritize defensive gaps
- Engineer practical detection improvements
- Retest detections against controlled activity
- Measure detection coverage before and after improvement
- Verify cleanup and operational health
- Document technical limitations accurately

## Lab Components

The exercise used:

- Kali Linux as the controlled simulation source
- Windows 11 as the approved target endpoint
- Sysmon for endpoint process and network telemetry
- Windows Defender Firewall logging
- Splunk Enterprise for telemetry search, correlation, and alerting
- Splunk Universal Forwarder for endpoint log collection
- Wazuh for endpoint visibility and rule-based alerting
- A Windows domain controller for normal enterprise identity and DNS services
- OPNsense as the isolated lab gateway and firewall

All activity remained inside the approved VioletOps lab.

## Authorized Scenario Scope

### Scenario 1 - T1046 Network Service Discovery

The first scenario used a limited TCP service-discovery test from the approved Kali source against the approved Windows target.

Only predefined Windows service ports were tested.

The activity was intentionally limited and did not include:

- Subnet-wide scanning
- Vulnerability exploitation
- Credential use
- Brute force
- Persistence
- Privilege escalation
- Malware
- Destructive actions

### Scenario 2 - T1018 Remote System Discovery

The second scenario used a limited ICMP echo test from the approved Kali source against the approved Windows target.

The purpose was to determine whether basic remote-system discovery activity produced usable defensive telemetry and direct detection coverage.

## Initial Telemetry Findings

### Scenario 1 - T1046

The controlled TCP activity produced a Sysmon Event ID 3 network connection event.

Splunk successfully indexed and correlated the event.

Wazuh Rule 92105 also generated an alert. However, the Wazuh rule classified the observed activity as behavior associated with Windows administrative-share access rather than the intended T1046 Network Service Discovery technique.

The event therefore demonstrated usable telemetry but also exposed a classification and detection-quality gap.

### Scenario 2 - T1018

The controlled ICMP test completed successfully with replies from the approved Windows target.

Initial endpoint review found no direct usable telemetry for the ICMP discovery activity.

The absence of telemetry prevented reliable technique-specific detection and investigation.

## Detection Gap Analysis

The purple-team analysis identified several defensive gaps.

### Priority 1 - Missing ICMP Telemetry

The most significant initial gap was the absence of direct endpoint telemetry for T1018 ICMP discovery.

Without usable ICMP telemetry, the SIEM could not reliably identify or alert on the controlled discovery activity.

### Priority 2 - Missing Direct T1046 Detection

Sysmon and Splunk contained usable T1046-related network evidence, but no direct Splunk detection existed for the technique.

Investigation therefore required manual searching and correlation.

### Priority 3 - Sysmon Field Extraction Limitations

Some Sysmon investigation fields required manual XML extraction in Splunk.

This reduced analyst efficiency and made correlation less convenient than fully parsed event fields.

### Priority 4 - Timestamp Quality

A stale embedded Sysmon UtcTime value was observed during investigation.

The inconsistency required analysts to rely on other validated event timing fields during correlation.

### Priority 5 - Wazuh Classification

Wazuh Rule 92105 generated useful visibility but mapped the observed network event to behavior that did not accurately describe the controlled TCP service-discovery activity.

The event remained useful as supporting telemetry, but the classification should not be treated as authoritative for the observed scenario.

## Detection Engineering Improvements

### T1046 Splunk Detection

A dedicated Splunk alert was created for T1046 Network Service Discovery.

The detection was designed around validated Sysmon network telemetry from the controlled discovery scenario.

The implementation was tested for:

- Search syntax
- Scheduled execution
- Matching telemetry
- Alert-job execution
- Retest visibility

The completed retest confirmed that the T1046 telemetry was available and the scheduled Splunk detection operated as intended.

### T1018 Telemetry Improvement

Windows Defender Firewall successful-connection logging was enabled on the Windows target Domain profile.

No new allow or block rule was created.

The existing inbound ICMPv4 Echo Request rule remained restricted to the approved simulation source.

The Splunk Universal Forwarder was extended to collect the Windows Firewall log.

The resulting telemetry was indexed with the sourcetype:

`windows:firewall`

This provided direct defensive visibility for the controlled ICMP discovery traffic.

### T1018 Splunk Detection

A dedicated Splunk alert was created for T1018 Remote System Discovery.

The detection searches the newly ingested Windows Firewall telemetry for the approved ICMP discovery pattern.

Runtime testing identified ingestion latency, so the scheduled search timing was tuned to account for late-arriving events while avoiding unnecessary repeated alerts from older telemetry.

Final validation confirmed:

- Firewall telemetry generation
- Splunk ingestion
- Detection matching
- Scheduled execution
- Triggered Alerts visibility

## Retest Results

### T1046 Retest

The controlled T1046 scenario was executed again after detection engineering.

The retest confirmed that required telemetry remained available and that the Splunk detection could evaluate the activity successfully.

### T1018 Retest

The controlled ICMP discovery scenario was executed again after Windows Firewall logging and Splunk collection were implemented.

The retest confirmed:

- Successful ICMP communication
- Windows Firewall telemetry generation
- Splunk ingestion
- Direct T1018 detection coverage
- Successful alert triggering

## Coverage Improvement

Before detection engineering:

| Measurement | Initial Coverage |
| --- | ---: |
| Direct technique-specific Splunk detections | 0 of 2 (0%) |
| Direct usable defensive telemetry | 1 of 2 (50%) |

After detection engineering and retesting:

| Measurement | Final Coverage |
| --- | ---: |
| Direct technique-specific Splunk detections | 2 of 2 (100%) |
| Direct usable defensive telemetry | 2 of 2 (100%) |

The improvement demonstrates the purple-team cycle of testing existing controls, identifying gaps, implementing defensive changes, and validating those changes through controlled retesting.

## Remaining Limitations

The exercise identified limitations that remain appropriate for future improvement:

- Wazuh Rule 92105 classification does not accurately represent the observed T1046 event.
- Visibility into filtered TCP attempts remains incomplete.
- Some Splunk Sysmon investigations still require manual XML field extraction.
- A stale embedded Sysmon UtcTime value remains a known telemetry-quality issue.
- Technique-specific Wazuh coverage remains incomplete compared with the improved Splunk coverage.

These limitations are documented rather than hidden because accurate reporting of defensive blind spots is part of effective SOC and purple-team work.

## Cleanup and Operational Validation

After testing, the environment was reviewed for unintended persistence or residual simulation activity.

Validation confirmed:

- No simulation activity remained running.
- No simulation-related scheduled-task persistence was identified.
- No Run or RunOnce persistence was identified.
- No simulation-related service persistence was identified.
- Windows endpoint health checks passed.
- Domain connectivity remained healthy.
- The domain secure channel remained valid.
- DNS resolution remained functional.
- Splunk continued receiving current endpoint telemetry.
- Sysmon, Windows Security, PowerShell, and Windows Firewall telemetry remained available.
- The Wazuh endpoint agent remained active.
- Recent Wazuh communication and integrity-monitoring activity were present.

No IP addressing, routing, VLAN, VM placement, hardware allocation, or firewall-rule scope changes were required during cleanup.

The Windows Firewall logging and Splunk collection changes remain intentional defensive configuration.

## Configuration Impact

Phase 10 introduced defensive monitoring and detection changes without changing the underlying VioletOps network architecture.

Implemented changes included:

- Windows Defender Firewall successful-connection logging on the target Domain profile
- Splunk Universal Forwarder collection of Windows Firewall telemetry
- `windows:firewall` telemetry ingestion
- A direct Splunk T1046 detection
- A direct Splunk T1018 detection
- Detection timing adjustments based on observed ingestion latency

The existing Splunk forwarding path and receiver remained in use.

No new VM, subnet, gateway, DNS, DHCP, NAT, VLAN, routing, or physical network architecture was introduced.

## Portfolio Evidence

The final Phase 10 portfolio evidence selection contains nine screenshots chosen to demonstrate the complete purple-team workflow without unnecessary duplication:

1. `P10-01_Scenario1_T1046_Execution.png` - Controlled T1046 execution.
2. `P10-02_Scenario2_T1018_Execution.png` - Controlled T1018 execution.
3. `P10-03_Scenario1_Wazuh_Rule92105_Correlation.png` - Wazuh correlation and classification-gap evidence.
4. `P10-04_Missing_and_Incomplete_Telemetry.png` - Documented telemetry and detection gaps.
5. `P10-07_T1018_Firewall_Telemetry_Ingested.png` - New Windows Firewall telemetry successfully indexed in Splunk.
6. `P10-08_T1018_Splunk_Alert_Triggered.png` - Direct T1018 Splunk alert successfully triggered.
7. `P10-09_T1046_Alert_Job_Validation.png` - Scheduled T1046 Splunk detection-job validation.
8. `P10-10_T1046_Retest_Telemetry.png` - T1046 retest detection telemetry.
9. `P10-11_T1018_Retest_Telemetry.png` - T1018 retest firewall telemetry.

The following screenshots are retained as supporting internal evidence but are not necessary for the final portfolio narrative:

- `P10-05_Malformed_T1046_Splunk_Detection.png` - Intermediate troubleshooting evidence from the malformed detection configuration.
- `P10-06_T1046_Splunk_Alert_Created.png` - Alert-creation evidence superseded by later runtime and retest validation.

Section 11 sanitization and sensitive-data review are complete; final repository review remains in Section 12.

## Interview Talking Points

- I designed a controlled purple-team validation exercise around two MITRE ATT&CK discovery techniques.
- I compared expected telemetry with what the defensive stack actually produced.
- I identified a complete telemetry gap for ICMP discovery and a direct detection gap for TCP service discovery.
- I found that an existing Wazuh alert provided visibility but classified the event inaccurately for the observed behavior.
- I enabled Windows Firewall successful-connection logging and forwarded that telemetry into Splunk.
- I created direct Splunk detections for both T1046 and T1018.
- I tuned scheduled detection timing after identifying real ingestion latency.
- I retested both scenarios rather than assuming the detections worked.
- Direct Splunk technique coverage improved from 0% to 100% across the two tested scenarios.
- Direct usable telemetry coverage improved from 50% to 100%.
- I documented remaining blind spots instead of treating detection improvement as perfect coverage.
- I verified cleanup, endpoint health, SIEM ingestion, and Wazuh agent health after testing.

## Conclusion

Phase 10 demonstrated the full purple-team improvement cycle: establish a safe baseline, emulate controlled adversary behavior, observe defensive results, identify gaps, engineer improvements, retest, measure coverage, and verify operational health.

The most important result was not simply that two alerts were created. The exercise demonstrated that defensive controls must be tested against real telemetry, detection gaps must be documented accurately, and every improvement must be validated through repeatable evidence.

The final environment provides direct Splunk detection coverage and usable defensive telemetry for both tested discovery scenarios while retaining documented limitations for future improvement.
