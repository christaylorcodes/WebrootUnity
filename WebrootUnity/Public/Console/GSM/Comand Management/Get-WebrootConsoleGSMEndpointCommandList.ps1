function Get-WebrootConsoleGSMEndpointCommandList {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-sites-siteId-endpoints-endpointId-commands_command_commandState_startDate_endDate_order_orderDirection_pageSize_pageNr
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteId,
        [string]$EndpointID,
        [string]$command,
        [string]$commandState,
        [datetime]$startDate,
        [datetime]$endDate,
        [string]$order,
        [string]$orderDirection,
        [int]$pageSize,
        [int]$pageNr,
        [switch]$All        
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteId)/endpoints/$($EndpointID)/commands?command=$($command)&commandState=$($commandState)&startDate=$($startDate)&endDate=$($endDate)&order=$($order)&orderDirection=$($orderDirection)&pageSize=$($pageSize)&pageNr=$($pageNr)"    
    
    Write-Verbose "Connecting"
    Connect-WebrootUnity
            
    try{
        $Obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        $Obj.Commands
        while($All -and ($($Obj.TotalAvailable) -gt ($Obj.PageNr * $Obj.PageSize))){
            $pageNr ++
            $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteId)/endpoints/$($EndpointID)/commands?command=$($command)&commandState=$($commandState)&startDate=$($startDate)&endDate=$($endDate)&order=$($order)&orderDirection=$($orderDirection)&pageSize=$($pageSize)&pageNr=$($pageNr)"    
            $Obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
            $Obj.Commands
        }
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }
    
}