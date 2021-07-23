function Resume-WebrootConsoleGSMSite {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/POST-api-console-gsm-gsmKey-sites-siteId-resume
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/access/gsm/$($GSMKey)/sites/$($SiteID)/resume"

    Write-Verbose "Connecting"
    Connect-WebrootUnity

    try{
        Invoke-RestMethod -Method Post -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
    }
    catch{
        Write-Error "Error: $($_)"
    }
}
