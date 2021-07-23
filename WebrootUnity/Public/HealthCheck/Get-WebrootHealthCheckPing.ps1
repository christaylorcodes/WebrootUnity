function Get-WebrootHealthCheckPing {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-health-ping
    [CmdletBinding()]
    param()

    $url = "https://unityapi.webrootcloudav.com/service/api/health/ping"

    try{
        Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json"
        Write-Output 'Success'
    }
    catch{
        Write-Error "Error: $($_)"
    }
}