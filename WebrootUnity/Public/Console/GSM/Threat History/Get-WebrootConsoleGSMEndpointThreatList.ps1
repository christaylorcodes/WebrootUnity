function Get-WebrootConsoleGSMEndpointThreatList {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-sites-siteId-endpoints-endpointId-threathistory_startDate_endDate_returnedInfo_pageSize_pageNr
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID,
        [string]$EndpointID,
        [datetime]$startDate,
        [datetime]$endDate,
        [string]$returnedInfo,
        [int]$pageSize,
        [int]$pageNr,
        [switch]$All
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/endpoints/$($EndpointID)/threathistory?startDate=$($startDate)&endDate=$($endDate)&returnedInfo=$($returnedInfo)&pageSize=$($pageSize)&pageNr=$($pageNr)"

    Write-Verbose "Connecting"
    Connect-WebrootUnity

    try{
        $Obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        $Obj.ThreatRecords
        while($All -and ($($Obj.TotalAvailable) -gt ($Obj.PageNr * $Obj.PageSize))){
            $pageNr ++
            $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/endpoints/$($EndpointID)/threathistory?startDate=$($startDate)&endDate=$($endDate)&returnedInfo=$($returnedInfo)&pageSize=$($pageSize)&pageNr=$($pageNr)"
            $Obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
            $Obj.ThreatRecords
        }
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }

}
