function Get-WebrootConsoleGSMSitePolicy {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-sites-siteId-policies-policyId
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey,
        [Parameter(Mandatory=$True)]
        $SiteID,
        [Parameter(Mandatory=$True)]
        $PolicyID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/policies/$($PolicyID)"


    Connect-WebrootUnity

    try{
        $obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        $obj.Policies
    }
    catch{
        Write-Error "Error: $($_)"
    }

}