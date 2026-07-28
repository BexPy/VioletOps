# Detection Case Study 5 — Repeated OPNsense Firewall Blocks

## Status

- Detection status: Complete
- Alert status: Enabled and verified
- Log source: OPNsense filterlog

## Threat Scenario

Repeated blocked connection attempts from one source to several destination ports can indicate port scanning or reconnaissance activity. Monitoring this pattern helps identify systems probing the firewall for exposed services.

## Data Source

- Platform: Splunk Enterprise
- Source: `udp:5514`
- Sourcetypes:
  - `opnsense:filterlog`
  - `opnsese:filterlog`
- Log type:
  - OPNsense firewall filter logs
- Action monitored:
  - `block`

## Severity

- Proposed severity: Medium
- Escalate to High when:
  - The source is unexpected or external
  - The scan targets sensitive services
  - The activity continues across multiple time windows
  - The scan is followed by successful connections
  - Related authentication or endpoint alerts appear

## Detection Logic

```spl
index=* source="udp:5514"
(sourcetype="opnsense:filterlog" OR sourcetype="opnsese:filterlog")
| rex field=_raw "filterlog\[\d+\]:\s+(?<filter_csv>.*)"
| eval fields=split(filter_csv,",")
| eval action=mvindex(fields,6)
| eval ip_version=mvindex(fields,8)
| eval src_ip=if(ip_version="4",mvindex(fields,18),mvindex(fields,15))
| eval dest_ip=if(ip_version="4",mvindex(fields,19),mvindex(fields,16))
| eval dest_port=if(ip_version="4",mvindex(fields,21),mvindex(fields,18))
| where action="block"
| bin _time span=5m
| stats count dc(dest_port) AS UniqueDestinationPorts values(dest_port) AS DestinationPorts by _time src_ip dest_ip
| where UniqueDestinationPorts>=5
| sort - _time
```

## Controlled Validation Result

- Generated a safe five-port connection test against the OPNsense WAN interface.
- Tested destination ports:
  - `65001`
  - `65002`
  - `65003`
  - `65004`
  - `65005`
- All connection attempts were blocked.
- Splunk detected:
  - 25 blocked events
  - 5 unique destination ports
  - 1 source address
  - 1 destination address
  - 1 five-minute detection window
- No firewall rule, NAT rule, or interface configuration was changed.

## Baseline and Noise Reduction

- Existing OPNsense logs contained high-volume multicast and IPv6 background blocks.
- A simple block-count rule would have been too noisy.
- Requiring at least 5 unique destination ports in 5 minutes reduced normal background noise.
- The 24-hour baseline returned 0 detections before the controlled test.
- The controlled test returned exactly 1 detection row.

## Current Infrastructure Impact

- Network architecture changed: No
- VM inventory changed: No
- IP addresses changed: No
- Firewall rules changed: No
- NAT, DHCP, VLAN, or routing changed: No
- Splunk listener or data-input configuration changed: No

## MITRE ATT&CK Mapping

- Tactic: Discovery
- Technique:
  - T1046 — Network Service Discovery

## Investigation Steps

1. Confirm the source, destination, timestamp, and blocked destination ports.
2. Review how many unique ports were targeted within the five-minute window.
3. Determine whether the source is internal, external, trusted, or unknown.
4. Check whether the activity was approved vulnerability scanning or administration.
5. Review OPNsense firewall logs before and after the detection window.
6. Search for successful connections from the same source.
7. Review related endpoint, authentication, DNS, and network telemetry.
8. Determine whether sensitive services were targeted.
9. Escalate when scanning continues, succeeds, or is followed by additional suspicious activity.

## Expected False Positives

- Approved vulnerability scans
- Network monitoring tools
- Administrative troubleshooting
- Asset-discovery tools
- Security testing
- Misconfigured applications repeatedly testing ports

## Escalation Guidance

Escalate when:

- The source is unknown or unauthorized
- The activity targets sensitive or administrative services
- The source scans several systems
- The scan continues across multiple time windows
- Successful connections follow the blocked attempts
- Related endpoint or authentication alerts appear
- The source cannot be explained by approved testing

## Remediation Guidance

- Preserve the relevant OPNsense and Splunk events.
- Confirm whether the source is authorized.
- Block or isolate unauthorized sources when appropriate.
- Review exposed services and firewall rules.
- Investigate any successful connections after the scan.
- Review affected endpoints for compromise.
- Search for similar activity across other destinations.
- Tune the detection only after confirmed false-positive analysis.

## Splunk Alert Configuration

- Alert name: `VioletOps - Repeated OPNsense Firewall Blocks`
- Description: Detects one source targeting at least five unique destination ports within five minutes in blocked OPNsense firewall logs.
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
