# Detection Case Study 4 — Suspicious Process Creation

## Status

- Detection status: Complete
- Alert status: Enabled and verified
- Event ID: 4688

## Threat Scenario

Attackers may use trusted Windows tools such as PowerShell and Command Prompt to launch suspicious commands. Monitoring unusual parent-child process relationships and suspicious command-line content can identify malicious execution while reducing noise from normal system activity.

## Data Source

- Platform: Splunk Enterprise
- Index: `main`
- Source: `WinEventLog:Security`
- Sourcetype: `XmlWinEventLog:Security`
- Event ID:
  - `4688` — A new process has been created

## Severity

- Proposed severity: Medium
- Escalate to High when:
  - Encoded or obfuscated commands are present
  - Download or payload-execution behavior is present
  - The process runs under a privileged account
  - The parent-child relationship is unexplained
  - Related network, file, registry, or persistence activity is found

## Detection Logic

```spl
index=main source="WinEventLog:Security" "<EventID>4688</EventID>"
| rex field=_raw "<Data Name='NewProcessName'>(?<NewProcessName>[^<]+)</Data>"
| rex field=_raw "<Data Name='ParentProcessName'>(?<ParentProcessName>[^<]*)</Data>"
| rex field=_raw "<Data Name='CommandLine'>(?<CommandLine>[^<]*)</Data>"
| eval ProcessLower=lower(NewProcessName), ParentLower=lower(ParentProcessName), CommandLower=lower(CommandLine)
| where (
    like(ProcessLower,"%\\cmd.exe")
    AND like(ParentLower,"%\\powershell.exe")
    AND (
        like(CommandLower,"%violetops-suspicious-process-test%")
        OR like(CommandLower,"%encodedcommand%")
        OR like(CommandLower,"%frombase64string%")
        OR like(CommandLower,"%downloadstring%")
        OR like(CommandLower,"%invoke-expression%")
    )
)
| table _time host NewProcessName ParentProcessName CommandLine
| sort - _time
```

## Controlled Validation Result

- Executed a harmless process-creation test.
- PowerShell launched `cmd.exe`.
- Test marker:
  - `VioletOps-Suspicious-Process-Test`
- Splunk captured:
  - 1 matching Event ID `4688`
- Verified fields:
  - New process: `cmd.exe`
  - Parent process: `powershell.exe`
  - Command line contained the unique test marker
- No malicious payload, persistence, download, or external communication occurred.

## Noise Reduction Result

- PowerShell launching Command Prompt occurred 8 times in 24 hours.
- Parent-child process matching alone was too broad.
- Adding suspicious command-line indicators reduced the result to 1 controlled event.

## Current Infrastructure Impact

- No IP-address changes
- No firewall-rule changes
- No NAT, DHCP, VLAN, or routing changes
- No VM resource or placement changes
- No Splunk listener or data-input changes

## MITRE ATT&CK Mapping

- Tactic: Execution
- Technique: T1059 — Command and Scripting Interpreter
- Sub-techniques:
  - T1059.001 — PowerShell
  - T1059.003 — Windows Command Shell

## Investigation Steps

1. Confirm the endpoint, account, timestamp, and Event ID `4688`.
2. Review the new process name, parent process, and full command line.
3. Determine whether the parent-child relationship is expected.
4. Check for encoded, obfuscated, download, or script-execution indicators.
5. Review related PowerShell Event IDs `4103` and `4104`.
6. Review nearby process-creation events before and after the alert.
7. Check for related network connections, file creation, registry changes, or persistence.
8. Confirm whether the activity was approved administration or testing.
9. Escalate when the process chain is unexplained or followed by additional suspicious activity.

## Expected False Positives

- Approved administrative scripts
- Software deployment or maintenance tools
- Security testing
- Help-desk troubleshooting
- Developers using PowerShell and Command Prompt
- Legitimate automation containing monitored keywords

## Escalation Guidance

Escalate when:

- Encoded or obfuscated command content is present
- A download or payload execution is observed
- A privileged account launches the process
- The parent-child relationship is unusual
- The user cannot explain the activity
- Related network, file, registry, credential, or persistence activity is found

## Remediation Guidance

- Preserve the full Event ID `4688` record and related telemetry.
- Isolate the endpoint when malicious execution is likely.
- Stop suspicious processes when appropriate.
- Remove malicious files, scripts, or persistence mechanisms.
- Reset affected credentials when compromise is suspected.
- Block confirmed malicious domains, addresses, or file hashes.
- Search other endpoints for the same process and command-line pattern.

## Splunk Alert Configuration

- Alert name: `VioletOps - Suspicious Process Creation`
- Description: Detects suspicious PowerShell-to-Command-Prompt process creation using Event ID 4688 and suspicious command-line indicators.
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
