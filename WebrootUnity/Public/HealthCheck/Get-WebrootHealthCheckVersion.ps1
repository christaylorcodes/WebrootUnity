function Get-WebrootHealthCheckVersion {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-health-version
    [CmdletBinding()]
    param()

    $url = "https://unityapi.webrootcloudav.com/service/api/health/version"
                
    try{
        $obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json"
        $obj.ServiceInformation
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }    
}