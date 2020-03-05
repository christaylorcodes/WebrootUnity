function Get-WebrootConsoleGSMSiteEndpointList {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-sites-siteId-endpoints_type_hostName_machineId_order_orderDirection_pageSize_pageNr
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteId,
        [string]$type,
        [string]$hostName,
        [string]$machineId,
        [string]$order,
        [string]$orderDirection,
        [int]$pageSize,
        [int]$pageNr,
        [switch]$All
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteId)/endpoints?type=$($type)&hostName=$($hostName)&machineId=$($machineId)&order=$($order)&orderDirection=$($orderDirection)&pageSize=$($pageSize)&pageNr=$($pageNr)"

    Write-Verbose "Connecting"
    Connect-WebrootUnity

    try{
        $Obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        $Obj.Endpoints
        while($All -and ($($Obj.TotalAvailable) -gt ($Obj.PageNr * $Obj.PageSize))){
            $pageNr ++
            $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteId)/endpoints?type=$($type)&hostName=$($hostName)&machineId=$($machineId)&order=$($order)&orderDirection=$($orderDirection)&pageSize=$($pageSize)&pageNr=$($pageNr)"
            $Obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
            $Obj.Endpoints
        }
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }

}