# Detection Case Study 1 — Repeated Failed Windows Logons

## Status

- Detection status: Logic validated
- Evidence status: Historical validation confirmed
- Alert status: Not yet saved as a Splunk alert
- Event ID: 4625

## Threat Scenario

An attacker may repeatedly attempt to authenticate to a Windows account using guessed or stolen passwords. Multiple failed logons against the same account within a short time may indicate password spraying, brute-force activity, credential misuse, or an account-lockout attempt.

## Data Source

- Platform: Splunk Enterprise
- Index: `main`
- Source: `WinEventLog:Security`
- Sourcetype: `XmlWinEventLog:Security`
- Windows Security Event ID: `4625`

## Severity

- Proposed severity: Medium
- Escalate to High when:
  - A privileged account is targeted
  - Multiple accounts are targeted
  - A remote or unexpected source address is present
  - Failures are followed by a successful logon

## Detection Logic

The detection groups failed Windows logons by account, source, workstation, and five-minute time window. It triggers when four or more Event ID 4625 events occur for the same account within a rolling five-minute window. This provides warning before the fifth failed attempt reaches the configured lockout threshold.

```spl
index=main source="WinEventLog:Security" "<EventID>4625</EventID>"
| rex field=_raw "<Data Name='TargetUserName'>(?<TargetUserName>[^<]+)</Data>"
| rex field=_raw "<Data Name='LogonType'>(?<LogonType>[^<]+)</Data>"
| rex field=_raw "<Data Name='IpAddress'>(?<IpAddress>[^<]+)</Data>"
| rex field=_raw "<Data Name='WorkstationName'>(?<WorkstationName>[^<]+)</Data>"
| rex field=_raw "<Data Name='Status'>(?<Status>[^<]+)</Data>"
| rex field=_raw "<Data Name='SubStatus'>(?<SubStatus>[^<]+)</Data>"
| sort 0 _time
| streamstats time_window=5m count AS FailedLogonCount by host TargetUserName
| where FailedLogonCount>=4
| table _time host TargetUserName FailedLogonCount LogonType IpAddress WorkstationName Status SubStatus
| sort - _time
```

## Validation Result

A controlled test generated repeated failed logons for the standard test account.

- WIN11 recorded fresh Windows Security Event ID 4625 telemetry.
- Splunk received the failed-logon events from the correct endpoint.
- The search identified the correct target account.
- Four failures were detected within a rolling five-minute window.
- The rolling-window logic avoided the blind spot caused by fixed five-minute clock boundaries.
- The detection alerts before the fifth failed attempt reaches the configured account-lockout threshold.

The detection logic and threshold were verified successfully.

## Current Infrastructure Impact

- No IP-address changes
- No firewall-rule changes
- No NAT, DHCP, VLAN, or routing changes
- No VM resource or placement changes
- No Splunk listener changes




## MITRE ATT&CK Mapping

- Tactic: Credential Access
- Technique: T1110 — Brute Force
- Relevant sub-techniques:
  - T1110.001 — Password Guessing
  - T1110.003 — Password Spraying

## Investigation Steps

1. Confirm the target account, endpoint, timestamps, and failure count.
2. Review the logon type and source address.
3. Determine whether the account is privileged, disabled, expired, or recently changed.
4. Search for additional Event ID 4625 activity against other accounts from the same source.
5. Search for Event ID 4624 successful logons after the failures.
6. Check for Event ID 4740 account lockout and related Kerberos or credential-validation events.
7. Compare the activity with expected user behavior, maintenance, scripts, and service accounts.
8. Escalate if the failures involve privileged accounts, multiple users, remote sources, or a later successful logon.

## Expected False Positives

- Users entering an old or mistyped password
- Cached credentials after a password change
- Scheduled tasks or services using expired credentials
- Mapped drives or applications retrying stored credentials
- Administrators performing approved authentication testing

## Escalation Guidance

Escalate when:

- A privileged or sensitive account is targeted
- The same source targets multiple accounts
- Failures continue across multiple time windows
- The source address or endpoint is unexpected
- A successful logon follows the failed attempts
- The activity cannot be explained by normal user or administrative behavior

## Remediation Guidance

- Confirm the user’s identity and recent activity.
- Reset the password when compromise is suspected.
- Unlock the account only after validating the source of the failures.
- Remove or update stale stored credentials.
- Disable the account temporarily when malicious activity is likely.
- Block or isolate the source system when appropriate.
- Review related endpoint and authentication telemetry for broader compromise.

## Wazuh Verification

- Wazuh Threat Hunting rule ID: `60122`
- Five authentication-failure alerts were visible during validation.
- Event ID `4625` was confirmed.
- The standard test account was identified correctly.
- The WIN11 endpoint was identified correctly.
- Failed-logon telemetry was therefore verified in both Wazuh and Splunk.

## Splunk Alert Configuration

- Alert name: `VioletOps - Repeated Failed Windows Logons`
- Status: Enabled
- Permissions: Private
- Alert type: Scheduled
- Schedule: Every 5 minutes
- Cron expression: `*/5 * * * *`
- Search time range: Last 5 minutes
- Trigger condition: Number of results is greater than `0`
- Trigger mode: Once
- Trigger action: Add to Triggered Alerts
- Triggered-alert expiration: 24 hours
- Splunk licensing note:
  - The scheduled alert will stop running after the Splunk Enterprise Trial license expires unless the lab is moved to a license that supports scheduled alerts.
