<#
.SYNOPSIS
Runs the VioletOps failed-logon investigation and response workflow.

.DESCRIPTION
Executes alert normalization, automated enrichment, risk-scoring and decision logic, and response-workflow generation for a controlled Windows Security Event ID 4625 alert.

The launcher creates timestamped JSON output files and appends a JSONL audit entry. It generates recommendations only and does not execute destructive containment actions.

.PARAMETER InputPath
Path to the raw Event ID 4625 alert JSON file.

The input file must contain all required alert fields, including Timestamp, Host, Account, EventId, DetectionName, and Severity.

.PARAMETER OutputDirectory
Directory where normalized, enriched, decision, incident-summary, and audit-log files are written.

When this parameter is not provided, the launcher creates and uses a Workflow Output folder beside the Scripts folder.

.EXAMPLE
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Invoke-VioletOpsFailedLogonWorkflow.ps1 -InputPath "C:\Path\Controlled_4625_Alert_Raw.json"

Runs the complete workflow using the specified raw-alert JSON file and the default output directory.

.EXAMPLE
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Invoke-VioletOpsFailedLogonWorkflow.ps1 -InputPath "C:\Path\Controlled_4625_Alert_Raw.json" -OutputDirectory "C:\Path\Workflow Output"

Runs the workflow and writes the generated files to a specified output directory.

.NOTES
Automatic destructive containment is disabled.

Account disabling, host isolation, firewall blocking, Active Directory changes, and evidence deletion require analyst approval and are not performed by this launcher.
#>


[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$InputPath,

    [Parameter(Mandatory = $false)]
    [string]$OutputDirectory
)

$ErrorActionPreference = "Stop"

$ScriptsFolder = Split-Path -Parent $MyInvocation.MyCommand.Path

if ([string]::IsNullOrWhiteSpace($OutputDirectory)) {
    $OutputDirectory = Join-Path (Split-Path -Parent $ScriptsFolder) "Workflow Output"
}
$RunTimestamp = Get-Date -Format "yyyyMMdd-HHmmss"

$NormalizeScript = Join-Path $ScriptsFolder "Normalize-VioletOpsAlert.ps1"
$EnrichmentScript = Join-Path $ScriptsFolder "Add-VioletOpsAlertEnrichment.ps1"
$DecisionScript = Join-Path $ScriptsFolder "Invoke-VioletOpsDecisionLogic.ps1"
$ResponseScript = Join-Path $ScriptsFolder "Invoke-VioletOpsResponseWorkflow.ps1"

$NormalizedOutput = Join-Path $OutputDirectory "Launcher_Normalized_$RunTimestamp.json"
$EnrichedOutput = Join-Path $OutputDirectory "Launcher_Enriched_$RunTimestamp.json"
$DecisionOutput = Join-Path $OutputDirectory "Launcher_Decision_$RunTimestamp.json"
$IncidentOutput = Join-Path $OutputDirectory "Launcher_Incident_$RunTimestamp.json"
$AuditLog = Join-Path $OutputDirectory "Launcher_Workflow_Audit.jsonl"

function Invoke-VioletOpsStage {
    param(
        [Parameter(Mandatory = $true)]
        [string]$StageName,

        [Parameter(Mandatory = $true)]
        [string]$ScriptPath,

        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    if (-not (Test-Path -LiteralPath $ScriptPath -PathType Leaf)) {
        throw "$StageName script not found: $ScriptPath"
    }

    Write-Output ""
    Write-Output "STARTING STAGE: $StageName"

    & powershell.exe `
        -NoProfile `
        -ExecutionPolicy Bypass `
        -File $ScriptPath `
        @Arguments

    if ($LASTEXITCODE -ne 0) {
        throw "$StageName failed with exit code $LASTEXITCODE."
    }

    Write-Output "STAGE COMPLETE: $StageName"
}

function Test-VioletOpsOutputFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$StageName,

        [Parameter(Mandatory = $true)]
        [string]$OutputPath
    )

    if (-not (Test-Path -LiteralPath $OutputPath -PathType Leaf)) {
        throw "$StageName did not create the expected output file: $OutputPath"
    }

    if ((Get-Item -LiteralPath $OutputPath).Length -eq 0) {
        throw "$StageName created an empty output file: $OutputPath"
    }
}
try {
    if (-not (Test-Path -LiteralPath $OutputDirectory -PathType Container)) {
        New-Item -ItemType Directory -Path $OutputDirectory -Force |
            Out-Null
    }

    Invoke-VioletOpsStage `
        -StageName "Alert normalization" `
        -ScriptPath $NormalizeScript `
        -Arguments @(
            "-InputPath", $InputPath,
            "-OutputPath", $NormalizedOutput
        )

    Test-VioletOpsOutputFile `
        -StageName "Alert normalization" `
        -OutputPath $NormalizedOutput

    Invoke-VioletOpsStage `
        -StageName "Automated enrichment" `
        -ScriptPath $EnrichmentScript `
        -Arguments @(
            "-InputPath", $NormalizedOutput,
            "-OutputPath", $EnrichedOutput
        )

    Test-VioletOpsOutputFile `
        -StageName "Automated enrichment" `
        -OutputPath $EnrichedOutput

    Invoke-VioletOpsStage `
        -StageName "Decision logic" `
        -ScriptPath $DecisionScript `
        -Arguments @(
            "-InputPath", $EnrichedOutput,
            "-OutputPath", $DecisionOutput
        )

    Test-VioletOpsOutputFile `
        -StageName "Decision logic" `
        -OutputPath $DecisionOutput

    Invoke-VioletOpsStage `
        -StageName "Response workflow" `
        -ScriptPath $ResponseScript `
        -Arguments @(
            "-DecisionInputPath", $DecisionOutput,
            "-IncidentOutputPath", $IncidentOutput,
            "-AuditLogPath", $AuditLog
        )

    Test-VioletOpsOutputFile `
        -StageName "Response workflow" `
        -OutputPath $IncidentOutput

    Test-VioletOpsOutputFile `
        -StageName "Response workflow audit logging" `
        -OutputPath $AuditLog

    $Incident = Get-Content -LiteralPath $IncidentOutput -Raw |
        ConvertFrom-Json

    Write-Output ""
    Write-Output "============================================================"
    Write-Output " VIOLETOPS FAILED LOGON WORKFLOW - ANALYST SUMMARY"
    Write-Output "============================================================"
    Write-Output "Workflow Status               : $($Incident.WorkflowStatus)"
    Write-Output "Risk Score                    : $($Incident.RiskScore)"
    Write-Output "Risk Level                    : $($Incident.RiskLevel)"
    Write-Output "Response Status               : $($Incident.ResponseStatus)"
    Write-Output "Analyst Approval Required     : $($Incident.AnalystApprovalRequired)"
    Write-Output "Automatic Containment Executed: $($Incident.AutomaticContainmentExecuted)"
    Write-Output "------------------------------------------------------------"
    Write-Output "Incident Output: $IncidentOutput"
    Write-Output "Audit Log      : $AuditLog"
    Write-Output "============================================================"
}
catch {
    Write-Error "VIOLETOPS WORKFLOW FAILED: $($_.Exception.Message)"
    exit 1
}
