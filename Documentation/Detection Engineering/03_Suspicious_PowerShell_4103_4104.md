# Detection Case Study 3 — Suspicious PowerShell Activity

## Status

- Detection status: Complete
- Alert status: Enabled and verified
- Event IDs: 4103 and 4104

## Threat Scenario

Attackers often use PowerShell to execute commands, download content, decode payloads, or run scripts in memory. Suspicious command patterns can indicate malicious execution, credential theft, persistence, or post-exploitation activity.

## Data Source

- Platform: Splunk Enterprise
- Index: `main`
- Source: `WinEventLog:Microsoft-Windows-PowerShell/Operational`
- Sourcetype: `XmlWinEventLog:Microsoft-Windows-PowerShell/Operational`
- Event IDs:
  - `4103` — Module logging
  - `4104` — Script block logging

## Severity

- Proposed severity: Medium
- Escalate to High when:
  - Encoded commands are used
  - Download or remote execution behavior is present
  - The command runs under a privileged account
  - The command is followed by suspicious process or network activity

## Detection Logic

```spl
index=main source="WinEventLog:Microsoft-Windows-PowerShell/Operational"
("<EventID>4103</EventID>" OR "<EventID>4104</EventID>")
("Invoke-Expression" OR "IEX" OR "-EncodedCommand" OR "FromBase64String" OR "DownloadString")
| rex field=_raw "<EventID>(?<EventID>\d+)</EventID>"
| rex field=_raw "<Data Name='ScriptBlockText'>(?<ScriptBlockText>[^<]*)</Data>"
| table _time host EventID ScriptBlockText _raw
| sort - _time
```

## Controlled Validation Result

- Executed a harmless test using `Invoke-Expression`.
- Test marker:
  - `VioletOps-Suspicious-PowerShell-Test`
- Splunk received:
  - 1 matching Event ID `4103`
  - 1 matching Event ID `4104`
- The detection identified the correct endpoint and command pattern.
- No malicious payload, download, persistence, or external communication occurred.

## Current Infrastructure Impact

- No IP-address changes
- No firewall-rule changes
- No NAT, DHCP, VLAN, or routing changes
- No VM resource or placement changes
- No Splunk listener changes

## MITRE ATT&CK Mapping

- Tactic: Execution
- Technique: T1059 — Command and Scripting Interpreter
- Sub-technique:
  - T1059.001 — PowerShell

## Investigation Steps

1. Confirm the endpoint, account, timestamp, and PowerShell event ID.
2. Review the full script block or command text.
3. Identify suspicious functions such as `Invoke-Expression`, encoded commands, downloads, or Base64 decoding.
4. Determine whether the command was expected administrative activity.
5. Review related process-creation telemetry for `powershell.exe` or `pwsh.exe`.
6. Check parent process, command line, user context, and execution path.
7. Review related network connections and downloaded files.
8. Search for persistence, credential access, or follow-on execution.
9. Escalate when the command is obfuscated, encoded, remote, privileged, or unexplained.

## Expected False Positives

- Approved administrator scripts
- Software-management tools
- Security testing
- Logon or maintenance scripts
- Developers using PowerShell automation
- Legitimate commands containing suspicious keywords

## Escalation Guidance

Escalate when:

- Encoded or obfuscated commands are present
- External downloads or remote execution are attempted
- The command runs as a privileged user
- The parent process is unusual
- The endpoint makes unexpected network connections
- Related process, file, registry, or persistence activity is observed
- The user cannot explain the activity

## Remediation Guidance

- Preserve the full script block and related event evidence.
- Isolate the endpoint when malicious execution is likely.
- Stop suspicious PowerShell processes when appropriate.
- Remove downloaded payloads or persistence mechanisms.
- Reset affected credentials when credential access is suspected.
- Block malicious domains, addresses, or file hashes.
- Review other endpoints for the same command pattern.

## Splunk Alert Configuration

- Alert name: `VioletOps - Suspicious PowerShell Activity`
- Status: Enabled
- Owner: `admin`
- App: `search`
- Permissions: Private
- Alert type: Scheduled
- Cron schedule: `*/5 * * * *`
- Search window: Last 5 minutes
- Trigger condition: Number of results is greater than `0`
- Trigger mode: Once
- Action: Add to Triggered Alerts
- Severity: Medium
- Expiration: 24 hours
- Verified: 2026-07-26
