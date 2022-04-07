function New-WebrootConsoleGSMSite {
    # https://unityapi.webrootcloudav.com/Docs/en/APIDoc/Api/POST-api-console-gsm-gsmKey-sites
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]
        [string]$GSMKey,
        [Parameter(Mandatory = $True)]
        [string]$SiteName,
        [Parameter(Mandatory = $True)]
        [int]$Seats,
        [Parameter(Mandatory = $True)]
        [string]$Comments,
        [ValidateSet('Annually', 'Quarterly', 'Monthly', 'Weekly')]
        [string]$BillingCycle,
        [string]$BillingDate,
        [switch]$GlobalPolicies,
        [switch]$GlobalOverrides,
        [string]$PolicyId,
        [Parameter(Mandatory = $True)]
        [string]$Emails,
        [switch]$Trial,
        [hashtable[]]$Modules
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites"

    $Body = @{
        SiteName = $SiteName
        Seats    = $Seats
        Comments = $Comments
        Emails   = $Emails
    }
    if ($BillingCycle) { $Body.BillingCycle = $BillingCycle }
    if ($BillingDate) { $Body.BillingDate = $BillingDate }
    if ($GlobalPolicies) { $Body.GlobalPolicies = $GlobalPolicies.IsPresent }
    if ($GlobalOverrides) { $Body.GlobalOverrides = $GlobalOverrides.IsPresent }
    if ($PolicyId) { $Body.PolicyId = $PolicyId }
    if ($Trial) { $Body.Trial = $Trial.IsPresent }
    if ($Modules) { $Body.Modules = $Modules }

    $Body = $Body | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-RestMethod, with body:`r`n$Body`r`n")) {
        Connect-WebrootUnity
        Write-Verbose $Body

        try {
            Invoke-RestMethod -Method Post -Uri $url -ContentType 'application/json' -Body $Body -Headers @{'Authorization' = "Bearer $($WebrootAuthToken.access_token)" }
        }
        catch {
            Write-Error "Error: $($_)"
        }
    }
}