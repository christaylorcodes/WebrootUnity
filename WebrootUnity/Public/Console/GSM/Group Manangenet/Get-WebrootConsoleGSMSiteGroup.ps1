function Get-WebrootConsoleGSMSiteGroup {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-sites-siteId-groups-groupId
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey,
        [Parameter(Mandatory=$True)]
        $SiteID,
        [Parameter(Mandatory=$True)]
        $GroupID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/groups/$($GroupID)"


    Connect-WebrootUnity

    try{
        $obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        $obj.Groups
    }
    catch{
        Write-Error "Error: $($_)"
    }

}