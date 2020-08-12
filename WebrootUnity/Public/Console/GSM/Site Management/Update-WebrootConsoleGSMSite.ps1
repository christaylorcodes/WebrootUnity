function Update-WebrootConsoleGSMSite {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/PUT-api-console-gsm-gsmKey-sites-siteId
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID,
        [Parameter(Mandatory=$False)]
        [string]$SiteName,
        [Parameter(Mandatory=$False)]
        [int]$Seats,
        [Parameter(Mandatory=$False)]
        [string]$Comments,
        [ValidateSet("Annually","Quarterly","Monthly","Weekly")]
        [string]$BillingCycle,
        [string]$BillingDate,
        [switch]$GlobalPolicies,
        [switch]$GlobalOverrides,
        [string]$PolicyId,
        [Parameter(Mandatory=$False)]
        [string]$Emails
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)"

    
    
    $Body = @{SiteName=$SiteName;
                Seats=$Seats;
                Comments=$Comments;
                BillingCycle=$BillingCycle;
                BillingDate=$BillingDate;
                GlobalPolicies=$GlobalPolicies;
                GlobalOverrides=$GlobalOverrides;
                PolicyId=$PolicyId;
                Emails=$Emails;}
    
    ($Body.GetEnumerator() | ? { -not $_.Value }) | % {$Body.Remove($_.Name) }
    
    $Body = $Body | ConvertTo-Json


    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-RestMethod, with body:`r`n$Body`r`n")) {
        Connect-WebrootUnity
        Write-Verbose $Body

        try{
            Invoke-RestMethod -Method Put -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        }
        catch{
            Write-Error "Error: $($Error[0])"
        }
    }
}
