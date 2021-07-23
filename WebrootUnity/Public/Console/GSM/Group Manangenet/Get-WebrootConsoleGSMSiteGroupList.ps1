function Get-WebrootConsoleGSMSiteGroupList {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-sites-siteId-groups
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey,
        [Parameter(Mandatory=$True)]
        $SiteID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/groups"

    Write-Verbose "Connecting"
    Connect-WebrootUnity

    try{
        $obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        $obj.Groups
    }
    catch{
        Write-Error "Error: $($_)"
    }

}