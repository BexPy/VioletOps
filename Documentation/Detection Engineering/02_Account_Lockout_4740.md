# Detection Case Study 2 — Windows Account Lockout

## Status

- Detection status: Historical telemetry verified
- Alert status: Not yet created
- Event ID: 4740
- Wazuh rule ID: 60115

## Threat Scenario

Repeated failed authentication attempts may lock a Windows account. A lockout can indicate password guessing, stale credentials, service-account failure, malicious access attempts, or user error.

## Data Source

- Platform: Wazuh
- Windows Security Event ID: `4740`
- Wazuh rule ID: `60115`
- Event source: Domain controller Security log

## Verified Event Fields

- Event ID: `4740`
- Target account: `privileged test account`
- Caller computer: `VIOLETOPS-WIN11`
- Agent: `VIOLETOPS-DC01`

## Severity

- Proposed severity: Medium
- Escalate to High when:
  - A privileged account is locked
  - Multiple accounts lock from the same caller
  - Lockouts repeat across multiple time windows
  - The source endpoint is unexpected
  - The lockout follows suspicious failed-logon activity

## Current Infrastructure Impact

- No IP-address changes
- No firewall-rule changes
- No NAT, DHCP, VLAN, or routing changes
- No VM resource or placement changes
- No Splunk listener changes

## Controlled Validation Result

- Generated exactly five failed sign-in attempts against the standard test account.
- Verified the account entered the locked state.
- Verified a fresh Windows Security Event ID `4740` on the domain controller.
- Verified the same fresh lockout event reached Wazuh.
- Wazuh rule ID: `60115`
- Wazuh alert level: `9`
- The event identified:
  - The locked account
  - The caller workstation
  - The domain controller agent
- The test account was unlocked after validation.

## Audit Policy Configuration

The domain-controller audit baseline was updated so Event ID `4740` is recorded consistently.

- Enabled advanced audit policy enforcement:
  - `SCENoApplyLegacyAuditPolicy = 1`
- Preserved existing Process Creation auditing.
- Added:
  - Account Lockout — Success and Failure
  - User Account Management — Success and Failure
- Verified the settings remained enabled after `gpupdate /force`.
- Event ID `4740` required the User Account Management audit subcategory.

## MITRE ATT&CK Mapping

- Tactic: Credential Access
- Technique: T1110 — Brute Force
- Relevant sub-techniques:
  - T1110.001 — Password Guessing
  - T1110.003 — Password Spraying

## Investigation Steps

1. Confirm the locked account, caller workstation, timestamp, and domain controller.
2. Determine whether the account is privileged, shared, disabled, expired, or recently changed.
3. Review Event ID 4625 failures preceding the lockout.
4. Review Event IDs 4771 and 4776 for related Kerberos or credential-validation failures.
5. Search for other locked accounts associated with the same caller workstation.
6. Check whether a successful Event ID 4624 logon occurred before or after the lockout.
7. Confirm whether the user changed a password or has stale saved credentials.
8. Escalate when the lockout cannot be explained by normal user or administrative activity.

## Expected False Positives

- A user repeatedly entering an incorrect password
- Cached credentials after a password change
- Scheduled tasks or services using an old password
- Mapped drives retrying stored credentials
- Mobile devices or applications using stale credentials
- Approved administrator testing

## Escalation Guidance

Escalate when:

- A privileged or sensitive account is locked
- Multiple accounts are locked from the same caller workstation
- Lockouts repeat after the account is unlocked
- The caller workstation is unexpected
- Related failed logons originate from multiple systems
- A successful logon follows suspicious authentication failures

## Remediation Guidance

- Verify the user’s identity and recent activity.
- Identify and correct stale stored credentials.
- Reset the password when compromise is suspected.
- Unlock the account only after validating the lockout source.
- Disable the account temporarily when malicious activity is likely.
- Isolate or investigate the caller workstation when appropriate.
- Review related authentication and endpoint telemetry for broader compromise.

## Wazuh Detection Configuration

- Detection platform: Wazuh
- Wazuh rule ID: `60115`
- Rule description: `User account locked out (multiple login errors)`
- Rule level: `9`
- Event ID: `4740`
- Detection status: Active and verified
- Historical results: 2 prior lockout alerts
- Fresh controlled validation: 1 new lockout alert
- Total verified hits: 3
- Splunk note:
  - Event ID `4740` is not currently available in Splunk because DC01 Security logs are not forwarded there.
  - Wazuh is therefore the authoritative alerting platform for this detection in Phase 6.
