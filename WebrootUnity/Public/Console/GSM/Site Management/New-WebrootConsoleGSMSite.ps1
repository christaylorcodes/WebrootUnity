function New-WebrootConsoleGSMSite {
    # https://unityapi.webrootcloudav.com/Docs/en/APIDoc/Api/POST-api-console-gsm-gsmKey-sites
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteName,
        [Parameter(Mandatory=$True)]
        [int]$Seats,
        [Parameter(Mandatory=$True)]
        [string]$Comments,
        [ValidateSet("Annually","Quarterly","Monthly","Weekly")]
        [string]$BillingCycle,
        [string]$BillingDate,
        [switch]$GlobalPolicies,
        [switch]$GlobalOverrides,
        [string]$PolicyId,
        [Parameter(Mandatory=$True)]
        [string]$Emails,
        [switch]$Trial


    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/access/gsm/$($GSMKey)/sites"

    $Body = @{
        SiteName=$SiteName;
        Seats=$Seats;
        Comments=$Comments;
        BillingCycle=$BillingCycle;
        BillingDate=$BillingDate;
        GlobalPolicies=$GlobalPolicies;
        GlobalOverrides=$GlobalOverrides;
        PolicyId=$PolicyId;
        Emails=$Emails;
        Trial=$Trial;
    } | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-RestMethod, with body:`r`n$Body`r`n")) {
        Connect-WebrootUnity
        Write-Verbose $Body

        try{
            Invoke-RestMethod -Method Post -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        }
        catch{
            Write-Error "Error: $($Error[0])"
        }
    }
}