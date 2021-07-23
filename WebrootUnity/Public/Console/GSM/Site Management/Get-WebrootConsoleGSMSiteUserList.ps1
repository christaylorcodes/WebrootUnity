function Get-WebrootConsoleGSMSiteUserList {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-sites-siteId-admins
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey,
        [Parameter(Mandatory=$True)]
        $SiteID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/admins"

    Write-Verbose "Connecting"
    Connect-WebrootUnity

    try{
        Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
    }
    catch{
        Write-Error "Error: $($_)"
    }

}