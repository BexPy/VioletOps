# VioletOps Phase 8 — Controlled Attack Simulation and SOC Investigation

## Case Study Status

Technically validated, sanitized, and approved for portfolio review.

## Executive Summary

This case study documents a controlled and authorized attack-simulation exercise performed against a designated Windows endpoint in an isolated cybersecurity lab.

The exercise evaluated:

- Safe execution of host and network service discovery techniques
- Endpoint and SIEM telemetry validation
- Cross-platform evidence correlation
- SOC investigation and risk assessment
- Cleanup and recovery verification

All actions were non-destructive, limited to the approved scope, and performed without credential access, exploitation, persistence, privilege escalation, or service disruption.

## Sanitization Notice

This public case study excludes:

- Internal IP addresses
- Personal usernames
- Physical host names
- Private domain information
- Sensitive internal file paths
- Credentials, tokens, and secrets
- Unsanitized screenshots

All included sections and evidence references were technically validated and reviewed for sanitization before GitHub publication.

## Security Objective and Authorized Scope

The objective of this exercise was to validate whether a SOC analyst could safely observe, investigate, and explain limited network discovery activity in a controlled lab.

The exercise was designed to confirm:

- Whether the approved target responded to host discovery
- Whether selected service ports appeared reachable
- Whether endpoint and SIEM telemetry matched the observed activity
- Whether the analyst could distinguish expected absent telemetry from a logging failure
- Whether the environment could be returned to its approved state after testing

The authorized scope was intentionally narrow:

- One approved simulation source
- One approved Windows target
- One isolated lab network
- ICMP echo requests for host discovery
- A limited TCP connect scan against four selected Windows service ports
- No subnet-wide scanning
- No Internet or third-party targets
- No credential use
- No brute force or password spraying
- No exploitation
- No privilege escalation
- No persistence
- No malware
- No destructive actions
- No service disruption

The exercise stopped if instability, out-of-scope traffic, logging failure, unexpected system impact, or incomplete cleanup was observed.

## Simulation Architecture

The simulation used a small, isolated enterprise-style lab architecture.

### Systems

- Kali Linux simulation source
  - Generated the approved ICMP and TCP discovery activity
- Windows 11 target endpoint
  - Received the controlled discovery activity
  - Ran Windows Security logging, Sysmon, a Splunk Universal Forwarder, and a Wazuh agent
- Splunk Enterprise server
  - Collected and searched Windows and Sysmon telemetry
- Wazuh server
  - Collected and reviewed endpoint security telemetry
- Domain controller
  - Provided DNS and normal domain services for the Windows endpoint
- OPNsense gateway
  - Provided network routing and firewall control for the isolated lab

### Evidence Flow

1. The Kali system sent approved discovery traffic to the Windows target.
2. The Windows endpoint processed the traffic and generated any applicable local telemetry.
3. The Splunk Universal Forwarder sent Windows and Sysmon events to Splunk.
4. The Wazuh agent sent endpoint telemetry to the Wazuh server.
5. The analyst compared command output, endpoint events, Splunk results, Wazuh results, and firewall behavior.
6. Cleanup checks confirmed the target, network, and monitoring systems remained healthy.

### Architecture Boundaries

- The simulation was limited to one source and one target.
- The lab network was isolated from unrelated systems.
- No Internet or third-party system was targeted.
- Internal addresses and host-specific identifiers are intentionally omitted from this public case study.

## MITRE ATT&CK Techniques

### T1018 — Remote System Discovery

Purpose:
- Confirm whether the approved Windows target was reachable from the authorized simulation source.

Method:
- Sent a small number of ICMP echo requests to the single approved target.

Observed result:
- The target responded successfully.
- All requests received replies.
- No packet loss occurred.

Detection note:
- Under the current logging configuration, no Windows Security or Sysmon event was expected for the ICMP activity.
- The command output served as the primary execution evidence.

### T1046 — Network Service Discovery

Purpose:
- Determine whether selected Windows service ports were reachable on the approved target.

Method:
- Performed a limited TCP connect scan against four approved ports associated with common Windows services.

Observed result:
- All tested ports returned filtered or no-response.
- No TCP connection completed.
- Matching Sysmon Event ID 3 activity was recorded for the approved T1046 simulation flow.
- The matching event was correlated in Splunk using the authorized source, target, and simulation time window.

Detection note:
- Sysmon and Splunk provided direct telemetry for the T1046 activity.
- Wazuh remained healthy and continued receiving background endpoint telemetry, but no direct T1046 alert was generated.
- The filtered scan result did not prevent Sysmon from recording the attempted TCP network activity.

### Technique Assessment

- Both techniques were limited to discovery activity.
- No exploitation, credential access, authentication attempt, privilege escalation, persistence, or destructive action occurred.
- The observed activity matched the approved simulation plan.

## Controlled Execution Method

The simulations were performed using a strict, step-by-step process.

### Preparation

- Confirmed the approved source and target systems.
- Verified target connectivity and monitoring health.
- Created a recovery checkpoint before testing.
- Confirmed stopping conditions and cleanup requirements.
- Limited the exercise to one target and two approved discovery techniques.

### Execution

1. Ran a small ICMP echo test against the approved Windows endpoint.
2. Verified the command completed successfully.
3. Ran a limited TCP connect scan against four selected Windows service ports.
4. Used no credentials, authentication attempts, exploitation, or persistence.
5. Rejected one mistyped command that referenced an unapproved port.
6. Executed and validated the exact approved scan command.
7. Stopped after the approved discovery actions were complete.

### Validation

- Reviewed endpoint Windows and Sysmon telemetry.
- Reviewed matching Splunk events.
- Reviewed matching Wazuh events.
- Compared expected and observed telemetry.
- Confirmed monitoring remained active during the test window.
- Confirmed no out-of-scope traffic, instability, or persistent change occurred.

### Cleanup

- Verified no simulation processes remained active.
- Confirmed the test-data folder was empty.
- Removed the temporary ICMP firewall rule.
- Checked common persistence locations.
- Verified normal endpoint operation.
- Verified Splunk and Wazuh remained healthy.
- Determined checkpoint restoration was not required.

## Resulting Telemetry

### Endpoint and Sysmon

- Sysmon Event ID 3 logging was active during the review window.
- Matching Sysmon Event ID 3 network activity was identified for the approved T1046 simulation flow.
- The event matched the authorized source, target, and simulation time window.
- No Windows account, payload, persistence mechanism, or target-side process execution was associated with the discovery activity.

### Splunk

- Splunk continued receiving Windows Security, Sysmon, and PowerShell Operational telemetry.
- The matching Sysmon Event ID 3 activity was located and correlated in Splunk.
- The event matched the approved T1046 source, target, and simulation window.
- This confirmed the Universal Forwarder and Splunk ingestion pipeline captured the discovery telemetry successfully.

### Wazuh

- The Wazuh endpoint agent remained active during the investigation window.
- Background endpoint and Sysmon telemetry remained visible.
- No direct T1018 or T1046 alert was generated.
- The available evidence confirmed Wazuh health and background visibility, but not direct detection of the simulated discovery activity.

### Telemetry Interpretation

- T1046 produced direct endpoint telemetry in Sysmon and matching correlation in Splunk.
- The filtered scan result did not prevent Sysmon from recording the attempted TCP network activity.
- T1018 remained supported primarily by command output because direct ICMP endpoint telemetry was not guaranteed under the current configuration.
- Wazuh remained healthy but did not provide a direct alert for either simulated technique.

### Detection Coverage

- T1018 was validated through command output because ICMP endpoint telemetry was not guaranteed under the current configuration.
- T1046 was directly validated through scan output, matching Sysmon Event ID 3 telemetry, and Splunk correlation.
- Wazuh provided health and background visibility but no direct T1018 or T1046 alert.
- No required telemetry was missing or delayed.

## SOC Investigation and Timeline

### Investigation Timeline

- **Host discovery began**
  - The authorized simulation source sent a small number of ICMP echo requests to the approved Windows target.

- **Host discovery completed**
  - The target responded successfully.
  - All requests received replies.
  - No packet loss occurred.

- **Command validation**
  - One mistyped scan command referenced an unapproved port.
  - That result was rejected and excluded from the approved simulation record.
  - The exact approved scan command was then executed.

- **Network service discovery executed**
  - A limited TCP connect scan tested four selected Windows service ports.
  - All tested ports returned filtered or no-response.
  - No TCP connection completed.

- **Telemetry review**
  - Matching Sysmon Event ID 3 activity was identified for the approved T1046 simulation flow.
  - The matching event was correlated in Splunk using the authorized source, target, and simulation time window.
  - Wazuh remained healthy and provided background endpoint visibility, but no direct T1018 or T1046 alert was generated.
  - The evidence supported an authorized, low-risk discovery activity rather than a collection failure.

- **Post-simulation validation**
  - No unexpected target was contacted.
  - No out-of-scope traffic was observed.
  - No instability or persistent configuration change was identified.
  - Monitoring remained healthy.

### Analyst Findings

- The activity matched T1018 Remote System Discovery and T1046 Network Service Discovery.
- The likely objective was to confirm host reachability and determine whether selected services were reachable.
- No credentials, authentication attempts, exploitation, privilege escalation, persistence, data modification, exfiltration, or disruption occurred.
- No target-side account or process was associated with a completed connection.
- Severity was assessed as Low.
- Risk was assessed as Low.
- Containment was not required.

### Investigation Conclusion

The activity was authorized, limited to discovery, and remained within the approved scope. Endpoint, Splunk, Wazuh, and network evidence supported the same conclusion. The environment remained stable and returned to its approved state after cleanup.

## Response Recommendation

### Immediate Response

- Confirm the activity was authorized and matched the approved simulation plan.
- Confirm the source and target remained within the approved scope.
- Preserve the command output, investigation timeline, and telemetry review.
- Verify no unexpected system, account, process, or follow-on activity was involved.

### Containment Decision

Containment was not required.

The activity was:

- Authorized
- Limited to discovery
- Restricted to one approved target
- Non-destructive
- Performed without credentials
- Performed without exploitation
- Performed without persistence
- Completed without service disruption or instability

Host isolation, account disablement, and additional firewall blocking were not necessary.

### Monitoring Recommendation

- Continue monitoring for unexpected host or service discovery from unknown sources.
- Escalate if discovery is followed by authentication attempts, exploitation, credential access, privilege escalation, persistence, or lateral movement.
- Review repeated or broader scanning as higher risk than the limited activity observed here.

### Recovery and Closure

- Stop all simulation activity.
- Remove temporary test artifacts and configuration changes.
- Verify no unauthorized persistence remains.
- Confirm normal endpoint operation.
- Confirm Splunk and Wazuh remain healthy.
- Retain the sanitized case study and approved evidence.

### Final Response Decision

The appropriate response was validation, monitoring, cleanup, and documentation rather than containment.

## Limitations and Future Improvements

### Limitations

- The exercise used only two discovery techniques.
- The TCP scan targeted four selected ports on one approved endpoint.
- All tested TCP ports were filtered, so no connection completed.
- Although no TCP connection completed, Sysmon recorded Event ID 3 network activity for the approved T1046 scan flow.
- ICMP activity did not generate guaranteed Windows or Sysmon telemetry under the current configuration.
- The investigation used command output, filtered network results, direct Sysmon telemetry, Splunk correlation, and Wazuh health validation.
- The project did not test exploitation, credential access, authentication attempts, privilege escalation, persistence, lateral movement, or destructive behavior.
- No automated detection rule or alert was created specifically for the simulated discovery activity.

### Future Improvements

- Repeat the T1046 test against a deliberately approved lab service that accepts a TCP connection.
- Develop and validate a dedicated Wazuh rule or alert for approved T1046 discovery telemetry.
- Create a dedicated Splunk detection search for unexpected network service discovery.
- Compare single-host discovery with broader but still tightly controlled lab-only scanning.
- Add packet-capture evidence to strengthen network-level correlation.
- Measure ingestion delay between endpoint event creation, Splunk availability, and Wazuh availability.
- Test analyst triage using an alert generated from the discovery telemetry.
- Maintain the same scope, safety, cleanup, and sanitization controls for all future simulations.

## Interview Talking Points

- I designed the exercise around strict authorization, limited scope, and clear stopping conditions.
- I mapped the activity to MITRE ATT&CK techniques T1018 and T1046.
- I used a Kali Linux source, a Windows endpoint target, Splunk, Wazuh, Sysmon, Windows logging, and firewall controls.
- I validated both the simulation result and the health of the monitoring pipeline.
- I correlated matching Sysmon Event ID 3 activity with Splunk even though the tested TCP ports were filtered and no connection completed.
- I separated a mistyped command from the approved simulation record instead of treating it as valid evidence.
- I correlated endpoint, Splunk, Wazuh, firewall, and command-line evidence before assigning severity and risk.
- I assessed the activity as Low severity and Low risk because it was authorized, non-destructive, and limited to discovery.
- I recommended monitoring and cleanup rather than unnecessary containment.
- I removed the temporary firewall rule and verified no persistence, instability, or logging failure remained.
- I documented the project with sanitization controls so it could be presented safely in a public portfolio.
- The main visibility limitation was that Wazuh remained healthy but did not generate a direct T1018 or T1046 alert.
- A strong future improvement would be to create and test dedicated Splunk and Wazuh detections for controlled network discovery activity.
