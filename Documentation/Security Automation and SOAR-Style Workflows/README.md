# VioletOps Failed-Logon Automation Workflow

## Overview

This project provides a portable PowerShell workflow for processing a controlled Windows Security Event ID 4625 alert.

The workflow:

1. Normalizes the alert
2. Adds security context
3. Calculates a deterministic risk score
4. Generates a response recommendation
5. Creates an incident summary
6. Appends an audit record

Automatic destructive containment is disabled.

## Requirements

- Windows PowerShell 5.1 or later
- Five scripts stored together in the `Scripts` folder
- A raw Event ID 4625 alert JSON file containing the required fields

## Required Scripts

- `Normalize-VioletOpsAlert.ps1`
- `Add-VioletOpsAlertEnrichment.ps1`
- `Invoke-VioletOpsDecisionLogic.ps1`
- `Invoke-VioletOpsResponseWorkflow.ps1`
- `Invoke-VioletOpsFailedLogonWorkflow.ps1`

## Required Input Fields

The raw JSON input must contain:

- `Timestamp`
- `Host`
- `Account`
- `EventId`
- `SourceAddress`
- `DetectionName`
- `Severity`

## Example Command

From PowerShell:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
    -File ".\Scripts\Invoke-VioletOpsFailedLogonWorkflow.ps1" `
    -InputPath ".\Controlled_4625_Alert_Raw_Sanitized.json"
Optional Output Directory

To choose a different output folder:
powershell.exe -NoProfile -ExecutionPolicy Bypass `
    -File ".\Scripts\Invoke-VioletOpsFailedLogonWorkflow.ps1" `
    -InputPath ".\Controlled_4625_Alert_Raw_Sanitized.json" `
    -OutputDirectory ".\Custom Output"
When OutputDirectory is not supplied, the launcher creates a Workflow Output folder beside the Scripts folder.

Generated Files

Each successful run creates:

Normalized alert JSON
Enriched alert JSON
Decision JSON
Incident-summary JSON
JSONL workflow audit record
Expected Safe Result

The included sanitized example produces:

Workflow Status: Success
Risk Score: 40
Risk Level: Medium
Response Status: Recommended
Analyst Approval Required: True
Automatic Containment Executed: False
Safety Controls

The workflow does not automatically:

Disable accounts
Reset passwords
Isolate hosts
Add firewall rules
Modify Active Directory
Delete evidence
Stop services
Terminate processes

These actions require analyst approval.

Public Sample Data

The included sample uses synthetic values such as:

WORKSTATION-01.example.local
test.user
192.0.2.25

Do not replace these values with sensitive production data before publishing output.

Additional Documentation
SOAR_Failed_Logon_Response_Playbook.md
Phase7_Failed_Logon_Automation_Case_Study.md
MITRE_ATTACK_Mapping.md
Example Output
