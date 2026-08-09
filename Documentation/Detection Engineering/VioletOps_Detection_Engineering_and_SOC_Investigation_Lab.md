# VioletOps Detection Engineering and SOC Investigation Lab

## Project Status

- Phase: 6
- Status: Complete
- Project type: Detection engineering and SOC investigation portfolio lab
- Phase 5 prerequisite: Complete and verified
- Phase 5 GitHub commit: `378e3f68dc40bb2fce294e824f1afe4b043ee240`

## Project Goal

Build and validate five interview-ready security detection case studies using telemetry already collected by Wazuh and Splunk.

## Approved Detection Scope

1. Repeated failed Windows logons — Windows Security Event ID 4625
2. Windows account lockout — Windows Security Event ID 4740
3. Suspicious PowerShell activity — PowerShell Event IDs 4103 and 4104
4. Suspicious process creation — Windows Security Event ID 4688 or Sysmon Event ID 1
5. Repeated OPNsense firewall blocks or controlled Kali scanning activity

## Required Content for Each Case Study

Each detection case study must include:

- Threat scenario
- Data source
- Detection logic or Splunk search
- Severity
- MITRE ATT&CK mapping
- Controlled validation test
- Alert or search evidence
- Investigation steps
- False-positive notes
- Escalation guidance
- Remediation guidance
- Sanitized portfolio documentation

## Data Sources

- Windows Security event logs
- PowerShell Operational event logs
- Sysmon Operational event logs
- OPNsense firewall filter logs
- Splunk Enterprise
- Wazuh security monitoring

## Phase 6 Working Rules

- Perform only controlled and authorized validation tests.
- Make one change or validation step at a time.
- Verify every detection with actual telemetry.
- Record event IDs, searches, severity, mappings, validation steps, and results.
- Do not publish private IP addresses, MAC addresses, SIDs, credentials, physical hostnames, or sensitive internal paths.
- Sanitize all evidence before GitHub publication.
- Do not change firewall rules, NAT, DHCP, VLANs, routing, VM resources, or IP assignments unless specifically required and documented.
- If it is not documented, it is not built.

## Case Study Status

| Case | Detection | Status |
|---|---|---|
| 1 | Repeated failed Windows logons — Event ID 4625 | Complete |
| 2 | Windows account lockout — Event ID 4740 | Complete |
| 3 | Suspicious PowerShell — Event IDs 4103 and 4104 | Complete |
| 4 | Suspicious process creation — Event ID 4688 or Sysmon Event ID 1 | Complete |
| 5 | OPNsense firewall blocks or controlled Kali scanning | Complete |

## Infrastructure Change Status

At Phase 6 start:

- No IP-address changes
- No firewall-rule changes
- No NAT changes
- No DHCP changes
- No VLAN changes
- No routing changes
- No virtual-switch changes
- No VM CPU, memory, disk, or placement changes
