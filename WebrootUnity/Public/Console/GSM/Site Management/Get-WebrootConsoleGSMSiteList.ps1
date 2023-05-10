function Get-WebrootConsoleGSMSiteList {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-usage-site-keyCode_billingDate_continuation
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites"


    Connect-WebrootUnity

    try{
        Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
    }
    catch{
        Write-Error "Error: $($_)"
    }

}