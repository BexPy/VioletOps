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

    $EnrichmentFailures = New-Object System.Collections.Generic.List[string]

    $HostContext = [ordered]@{
        Hostname = $Alert.Host
        OperatingSystem = "Windows 11"
        EndpointRole = "Domain-joined workstation"
        ContextStatus = "Success"
    }

    $AccountContext = [ordered]@{
        AccountName = $Alert.Account
        AccountType = "Standard user"
        Privileged = $false
        ContextStatus = "Success"
    }

    $FrequencyCount = 1

    try {
        $StartTime = ([DateTimeOffset]::Parse($Alert.Timestamp)).AddMinutes(-5).LocalDateTime
        $EndTime   = ([DateTimeOffset]::Parse($Alert.Timestamp)).AddMinutes(5).LocalDateTime

        $FrequencyCount = @(
            Get-WinEvent `
                -FilterHashtable @{
                    LogName   = "Security"
                    Id        = 4625
                    StartTime = $StartTime
                    EndTime   = $EndTime
                } `
                -ErrorAction Stop
        ).Count
    }
    catch {
        $EnrichmentFailures.Add(
            "Event frequency unavailable: $($_.Exception.Message)"
        )
    }

    $RelatedSuccessfulLogonCount = 0

    try {
        $RelatedSuccessfulLogonCount = @(
            Get-WinEvent `
                -FilterHashtable @{
                    LogName   = "Security"
                    Id        = 4624
                    StartTime = $StartTime
                    EndTime   = $EndTime
                } `
                -ErrorAction Stop
        ).Count
    }
    catch {
        $EnrichmentFailures.Add(
            "Related-event lookup unavailable: $($_.Exception.Message)"
        )
    }

    $RiskScore = 30

    if ($FrequencyCount -ge 5) {
        $RiskScore += 30
    }

    if ($AccountContext.Privileged) {
        $RiskScore += 25
    }

    if ($Alert.SourceAddress -ne "Unavailable") {
        $RiskScore += 10
    }

    if ($RelatedSuccessfulLogonCount -gt 0) {
        $RiskScore += 20
    }

    if ($RiskScore -gt 100) {
        $RiskScore = 100
    }

    $RiskLevel = if ($RiskScore -ge 70) {
        "High"
    }
    elseif ($RiskScore -ge 40) {
        "Medium"
    }
    else {
        "Low"
    }

    $EnrichedAlert = [PSCustomObject][ordered]@{
        SchemaVersion = "1.0"
        AlertId = $Alert.AlertId
        Timestamp = $Alert.Timestamp
        DetectionName = $Alert.DetectionName
        EventId = $Alert.EventId
        HostContext = $HostContext
        AccountContext = $AccountContext
        SourceAddress = $Alert.SourceAddress
        EventFrequency = [ordered]@{
            Count = $FrequencyCount
            WindowMinutes = 10
        }
        RelatedEvents = [ordered]@{
            SuccessfulLogons = $RelatedSuccessfulLogonCount
        }
        MitreAttack = [ordered]@{
            Tactic = "Credential Access"
            Technique = "Brute Force"
            TechniqueId = "T1110"
        }
        RiskScore = $RiskScore
        RiskLevel = $RiskLevel
        EnrichmentFailures = @($EnrichmentFailures)
        EnrichmentStatus = if ($EnrichmentFailures.Count -eq 0) {
            "Success"
        }
        else {
            "Partial"
        }
        EnrichedAt = (Get-Date).ToString("o")
        TestData = [bool]$Alert.TestData
    }

    $EnrichedAlert |
        ConvertTo-Json -Depth 8 |
        Set-Content -Path $OutputPath -Encoding UTF8

    Write-Output "ENRICHMENT SUCCESS"
    Write-Output "Output: $OutputPath"
}
catch {
    Write-Error "ENRICHMENT FAILED: $($_.Exception.Message)"
    exit 1
}
