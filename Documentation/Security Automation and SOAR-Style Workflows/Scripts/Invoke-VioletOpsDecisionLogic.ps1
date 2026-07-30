[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript({ Test-Path $_ -PathType Leaf })]
    [string]$InputPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath
)

$ErrorActionPreference = "Stop"

try {
    $Alert = Get-Content -Path $InputPath -Raw | ConvertFrom-Json

    if ($null -eq $Alert.RiskScore) {
        throw "RiskScore is missing."
    }

    $RiskScore = [int]$Alert.RiskScore

    $RiskLevel = if ($RiskScore -ge 70) {
        "High"
    }
    elseif ($RiskScore -ge 40) {
        "Medium"
    }
    else {
        "Low"
    }

    $Decision = switch ($RiskLevel) {
        "High" {
            "Escalate immediately and request analyst-approved containment."
        }
        "Medium" {
            "Investigate promptly and monitor for additional failed or successful logons."
        }
        "Low" {
            "Document and monitor. No immediate containment recommended."
        }
    }

    $FalsePositiveConsiderations = @(
        "User may have entered an outdated password.",
        "A saved credential or scheduled task may be using an old password.",
        "The failed logon may be part of an approved administrative test.",
        "Local or loopback source addresses may indicate activity from the same endpoint."
    )

    $EscalationCriteria = @(
        "Risk score is 70 or higher.",
        "A privileged account is targeted.",
        "Repeated failures affect multiple accounts.",
        "A successful logon follows repeated failures.",
        "The source address is unexpected or external.",
        "Related suspicious activity is detected."
    )

    $ResponseControls = [ordered]@{
        AutomaticDestructiveActionsAllowed = $false
        AnalystApprovalRequired            = $true
        AccountDisableAllowedAutomatically = $false
        HostIsolationAllowedAutomatically  = $false
        FirewallBlockAllowedAutomatically  = $false
    }

    $DecisionResult = [PSCustomObject][ordered]@{
        AlertId                    = $Alert.AlertId
        DetectionName              = $Alert.DetectionName
        RiskScore                  = $RiskScore
        RiskLevel                  = $RiskLevel
        Decision                   = $Decision
        FalsePositiveConsiderations = $FalsePositiveConsiderations
        EscalationCriteria         = $EscalationCriteria
        ResponseControls           = $ResponseControls
        RecommendedActionStatus    = "Recommended"
        ContainmentApprovalStatus  = "Pending analyst approval"
        DecisionStatus             = "Success"
        TestData                   = [bool]$Alert.TestData
    }

    $DecisionResult |
        ConvertTo-Json -Depth 8 |
        Set-Content -Path $OutputPath -Encoding UTF8

    Write-Output "DECISION LOGIC SUCCESS"
    Write-Output "Risk Level: $RiskLevel"
    Write-Output "Analyst Approval Required: True"
}
catch {
    Write-Error "DECISION LOGIC FAILED: $($_.Exception.Message)"
    exit 1
}
