[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript({ Test-Path $_ -PathType Leaf })]
    [string]$DecisionInputPath,

    [Parameter(Mandatory = $true)]
    [string]$IncidentOutputPath,

    [Parameter(Mandatory = $true)]
    [string]$AuditLogPath
)

$ErrorActionPreference = "Stop"

try {
    $Decision = Get-Content -Path $DecisionInputPath -Raw | ConvertFrom-Json
    $RunId = "RUN-{0}" -f (Get-Date -Format "yyyyMMdd-HHmmss")

    $InvestigationSteps = @(
        "Review failed-logon frequency and time window.",
        "Confirm whether the targeted account owner expected the activity.",
        "Review related successful logons.",
        "Check the source address and workstation context.",
        "Review nearby authentication and endpoint events.",
        "Escalate if privileged access or additional suspicious activity is found."
    )

    $ContainmentRecommendations = @(
        "Reset credentials if account compromise is confirmed.",
        "Disable the account only with analyst approval.",
        "Isolate the endpoint only with analyst approval.",
        "Block a malicious source address only with analyst approval.",
        "Preserve relevant logs before making containment changes."
    )

    $SafeResponseAction = "Generated incident summary and audit record."

    $Incident = [PSCustomObject][ordered]@{
        RunId                       = $RunId
        AlertId                     = $Decision.AlertId
        DetectionName               = $Decision.DetectionName
        RiskScore                   = $Decision.RiskScore
        RiskLevel                   = $Decision.RiskLevel
        Decision                    = $Decision.Decision
        InvestigationSteps          = $InvestigationSteps
        ContainmentRecommendations  = $ContainmentRecommendations
        SafeResponseAction          = $SafeResponseAction
        ResponseStatus              = "Recommended"
        AnalystApprovalRequired     = $Decision.ResponseControls.AnalystApprovalRequired
        ContainmentApprovalStatus   = $Decision.ContainmentApprovalStatus
        AutomaticContainmentExecuted = $false
        WorkflowStatus              = "Success"
        GeneratedAt                 = (Get-Date).ToString("o")
        TestData                    = [bool]$Decision.TestData
    }

    $Incident |
        ConvertTo-Json -Depth 8 |
        Set-Content -Path $IncidentOutputPath -Encoding UTF8

    $AuditEntry = [PSCustomObject][ordered]@{
        RunId        = $RunId
        Timestamp    = (Get-Date).ToString("o")
        AlertId      = $Decision.AlertId
        Action       = "Generate incident summary"
        Status       = "Executed"
        SafeAction   = $true
        AnalystApprovalRequired = $Decision.ResponseControls.AnalystApprovalRequired
        ContainmentExecuted     = $false
        Result        = "Incident summary created successfully"
    }

    $AuditEntry |
        ConvertTo-Json -Compress |
        Add-Content -Path $AuditLogPath -Encoding UTF8

    Write-Output "RESPONSE WORKFLOW SUCCESS"
    Write-Output "Run ID: $RunId"
    Write-Output "Response Status: Recommended"
    Write-Output "Analyst Approval Required: $($Decision.ResponseControls.AnalystApprovalRequired)"
    Write-Output "Automatic Containment Executed: False"
}
catch {
    Write-Error "RESPONSE WORKFLOW FAILED: $($_.Exception.Message)"
    exit 1
}
