function Get-WebrootConsoleGSMSite {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-sites-siteId
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey,
        $SiteID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)"

    Write-Verbose "Connecting"
    Connect-WebrootUnity

    try{
        Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
    }
    catch{
        Write-Error "Error: $($_)"
    }

}