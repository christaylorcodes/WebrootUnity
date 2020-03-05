function Get-WebrootKeycodeUsageGSM {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-usage-site-keyCode_billingDate_continuation
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $KeyCode,
        $billingDate,
        $continuation,
        [switch]$All
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/usage/gsm/$($keyCode)?billingDate=$($billingDate)&continuation=$($continuation)"

    Write-Verbose "Connecting"
    Connect-WebrootUnity

    try{
        $obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        $Obj.QueryResults
        if($All){
            while($Obj.ContinuationURI){
                Connect-WebrootUnity
                $Obj = Invoke-RestMethod -Method Get -uri $Obj.ContinuationURI -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
                $Obj.QueryResults
            }
        }
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }

}