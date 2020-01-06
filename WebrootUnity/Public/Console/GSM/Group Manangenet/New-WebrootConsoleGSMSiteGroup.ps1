function New-WebrootConsoleGSMSiteGroup {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/POST-api-console-gsm-gsmKey-sites-siteId-groups
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID,
        [Parameter(Mandatory=$True)]
        [string]$GroupName,
        [Parameter(Mandatory=$True)]
        [string]$GroupDescription,
        [string]$PolicyId
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/groups"
    
    $Body = @{GroupName=$GroupName;
                GroupDescription=$GroupDescription;
                PolicyId=$PolicyId;}
    $Body = $Body | ConvertTo-Json


    Write-Verbose "Connecting"
    Connect-WebrootUnity
            
    try{
        Invoke-RestMethod -Method Post -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }
    
}
