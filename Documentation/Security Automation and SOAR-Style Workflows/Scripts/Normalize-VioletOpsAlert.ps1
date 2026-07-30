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
    $RawAlert = Get-Content -Path $InputPath -Raw | ConvertFrom-Json

    $RequiredFields = @(
        "Timestamp",
        "Host",
        "Account",
        "EventId",
        "DetectionName",
        "Severity"
    )

    $MissingFields = foreach ($Field in $RequiredFields) {
        if (
            -not $RawAlert.PSObject.Properties.Name.Contains($Field) -or
            [string]::IsNullOrWhiteSpace([string]$RawAlert.$Field)
        ) {
            $Field
        }
    }

    if ($MissingFields) {
        throw "Required field(s) missing or empty: $($MissingFields -join ', ')"
    }

    $NormalizedAlert = [PSCustomObject][ordered]@{
        SchemaVersion   = "1.0"
        AlertId         = "VO-{0}-{1}" -f $RawAlert.EventId, (
            [DateTimeOffset]::Parse($RawAlert.Timestamp).ToString("yyyyMMddHHmmss")
        )
        Timestamp       = [DateTimeOffset]::Parse($RawAlert.Timestamp).ToString("o")
        Host            = [string]$RawAlert.Host
        Account         = [string]$RawAlert.Account
        EventId         = [int]$RawAlert.EventId
        SourceAddress   = if (
            [string]::IsNullOrWhiteSpace([string]$RawAlert.SourceAddress) -or
            $RawAlert.SourceAddress -eq "-"
        ) {
            "Unavailable"
        }
        else {
            [string]$RawAlert.SourceAddress
        }
        DetectionName   = [string]$RawAlert.DetectionName
        Severity        = ([string]$RawAlert.Severity).Trim()
        Provider        = [string]$RawAlert.Provider
        WorkstationName = [string]$RawAlert.WorkstationName
        LogonType       = [string]$RawAlert.LogonType
        Status          = [string]$RawAlert.Status
        TestData        = [bool]$RawAlert.TestData
        NormalizedAt    = (Get-Date).ToString("o")
        NormalizationStatus = "Success"
    }

    $NormalizedAlert |
        ConvertTo-Json -Depth 5 |
        Set-Content -Path $OutputPath -Encoding UTF8

    Write-Output "NORMALIZATION SUCCESS"
    Write-Output "Output: $OutputPath"
}
catch {
    Write-Error "NORMALIZATION FAILED: $($_.Exception.Message)"
    exit 1
}
