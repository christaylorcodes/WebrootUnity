function Set-WebrootConsoleGSMGroupPolicy {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/PUT-api-console-gsm-gsmKey-sites-siteId-groups-groupId-endpoints-policy
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID,
        [Parameter(Mandatory=$True)]
        [string]$GroupID,
        [Parameter(Mandatory=$True)]
        [string]$PolicyId
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/groups/$($GroupID)/endpoints/policy"
    
    $Body = @{PolicyId=$PolicyId;}
    $Body = $Body | ConvertTo-Json

    Write-Verbose "Connecting"
    Connect-WebrootUnity
            
    try{
        Invoke-RestMethod -Method Put -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }
    
}