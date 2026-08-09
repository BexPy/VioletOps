# VioletOps

VioletOps is a dual-host cybersecurity homelab and SOC portfolio environment built to demonstrate practical blue-team, detection engineering, security automation, SOC investigation, attack simulation, and purple-team validation skills.

The project was built and validated across 10 phases using Microsoft Hyper-V, OPNsense, Windows Active Directory, Splunk Enterprise, Wazuh, Sysmon, Windows event logging, PowerShell, and Kali Linux.

**Project Status:** Fully complete
**Final Validation:** August 8, 2026

---

## What This Project Demonstrates

- Enterprise-style virtual infrastructure using Microsoft Hyper-V
- Network segmentation and firewall administration with OPNsense
- Windows Active Directory and domain-joined endpoint administration
- Centralized Windows, Sysmon, firewall, and network telemetry
- Detection engineering in Splunk and Wazuh
- SOC alert triage and investigation workflows
- MITRE ATT&CK technique mapping
- PowerShell-based SOAR-style automation with human approval controls
- Controlled attack simulation and telemetry correlation
- Purple-team detection-gap analysis, tuning, retesting, and validation
- Documentation, evidence handling, sanitization, and Git-based change control

---

## Core Technologies

| Area | Technologies |
|---|---|
| Virtualization | Microsoft Hyper-V |
| Firewall / Routing | OPNsense |
| Identity | Windows Server Active Directory |
| Endpoint | Windows 11 |
| SIEM | Splunk Enterprise |
| Security Monitoring | Wazuh |
| Endpoint Telemetry | Sysmon, Windows Event Logs, Windows Defender Firewall Logs |
| Automation | PowerShell |
| Attack Simulation | Kali Linux, Nmap |
| Framework | MITRE ATT&CK |
| Version Control | Git / GitHub |

---

## Lab Architecture

VioletOps runs across two physical Hyper-V hosts with dedicated security, infrastructure, monitoring, and attack-simulation virtual machines.

Primary virtual systems include:

- OPNsense firewall and gateway
- Windows Server domain controller
- Windows 11 domain workstation
- Splunk Enterprise SIEM
- Wazuh security monitoring platform
- Kali Linux attack-simulation host

Network and host documentation is sanitized for public publication.

[View the dual-host architecture baseline](Documentation/Architecture/VioletOps_Dual_Host_Baseline.md)

[View the VM inventory](Documentation/VM%20Inventory/VioletOps_VM_Inventory.md)

---

## Detection Engineering

VioletOps includes detection and investigation work covering Windows authentication, account lockout, PowerShell activity, suspicious process execution, and network activity.

The project includes five documented detection case studies:

- Repeated failed Windows logons
- Windows account lockout
- Suspicious PowerShell execution
- Suspicious process execution
- OPNsense firewall blocks and controlled scanning

[View the Detection Engineering and SOC Investigation Lab](Documentation/Detection%20Engineering/VioletOps_Detection_Engineering_and_SOC_Investigation_Lab.md)

---

## Security Automation

Phase 7 introduced a PowerShell-based SOAR-style workflow that performs:

- Alert normalization
- Context enrichment
- Risk scoring
- Response recommendation
- Human approval
- Audit logging

The workflow intentionally avoids automatic containment so analyst approval remains part of the response process.

[View the Security Automation project](Documentation/Security%20Automation%20and%20SOAR-Style%20Workflows/README.md)

---

## SOC Operations

Phase 9 simulated a SOC analyst operational workflow.

During the exercise:

- 21 alerts were reviewed
- 2 investigation cases were created
- Both cases were classified as false positives
- No escalation was required
- Shift-handoff documentation was produced

[View the SOC Operations case study](Documentation/SOC%20Operations/Phase9_SOC_Operations_Case_Study.md)

---

## Purple Team Validation

Phase 10 tested whether the existing monitoring stack could directly detect controlled discovery activity mapped to:

- **T1046 — Network Service Discovery**
- **T1018 — Remote System Discovery**

Initial direct technique-specific Splunk detection coverage was **0 of 2 scenarios**.

After detection engineering and telemetry improvements, direct detection coverage was **2 of 2 scenarios**.

The work included:

1. Controlled technique execution
2. Endpoint, Splunk, and Wazuh telemetry review
3. Detection-gap analysis
4. MITRE ATT&CK mapping review
5. New Splunk detection creation
6. Windows Firewall telemetry improvement
7. Retesting
8. Alert validation
9. Cleanup and operational review

[View the Phase 10 Purple Team case study](Documentation/Purple%20Team/Phase10_Purple_Team_Case_Study.md)

---

## Selected Portfolio Evidence

Sanitized screenshots are included with the relevant case studies to demonstrate:

- Attack execution
- SIEM telemetry
- Wazuh correlation
- Splunk alert creation
- Triggered alerts
- Detection retesting
- SOC investigation workflow

Only sanitized portfolio evidence is published. Raw investigative artifacts remain outside the public repository.

---

## Documentation

Key project documentation includes:

- [Architecture](Documentation/Architecture/)
- [Detection Engineering](Documentation/Detection%20Engineering/)
- [Firewall Rules](Documentation/Firewall%20Rules/VioletOps_Firewall_Rules.md)
- [IP Addressing Plan](Documentation/IP%20Addressing%20Plan/VioletOps_IP_Addressing_Plan.md)
- [VM Inventory](Documentation/VM%20Inventory/VioletOps_VM_Inventory.md)
- [SOC Operations](Documentation/SOC%20Operations/)
- [Security Automation](Documentation/Security%20Automation%20and%20SOAR-Style%20Workflows/)
- [Attack Simulation](Documentation/Attack%20Simulation/)
- [Purple Team](Documentation/Purple%20Team/)
- [Build Log](Documentation/Build%20Log/VioletOps_Build_Log.md)

---

## Security and Sanitization

Public documentation is intentionally sanitized.

Internal IP addresses, MAC addresses, hardware identifiers, credentials, personal information, and other sensitive infrastructure details are either removed or replaced with descriptive placeholders before publication.

---

## Project Outcome

VioletOps progressed from infrastructure deployment through logging, detection engineering, automation, attack simulation, SOC operations, and purple-team validation.

The completed environment provides a practical portfolio example of how a SOC analyst can move from receiving telemetry to investigating alerts, identifying detection gaps, engineering improvements, and validating those improvements through controlled retesting.
