function Get-WebrootEndpointStatusGSM {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $KeyCode,
        $machineId,
        $returnedInfo,
        $modifiedSince,
        [int]$batchSize,
        $continuation,
        [switch]$All
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/status/gsm/$($KeyCode)?machineId=$($machineId)&returnedInfo=$($returnedInfo)&modifiedSince=$($modifiedSince)&batchSize=$($batchSize)&continuation=$($continuation)"


    Connect-WebrootUnity

    try{
        $Obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
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
        Write-Error "Error: $($_)"
    }

}