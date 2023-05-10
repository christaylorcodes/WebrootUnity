function Disable-WebrootConsoleGSMEndpoint {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/POST-api-console-gsm-gsmKey-sites-siteId-endpoints-deactivate
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]
        [string]$GSMKey,
        [Parameter(Mandatory = $True)]
        [string]$SiteID,
        [string]$EndpointsList
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/endpoints/deactivate"

    $Body = @{EndpointsList = $EndpointsList; } | ConvertTo-Json

    Connect-WebrootUnity

    try {
        Invoke-RestMethod -Method Post -Uri $url -ContentType 'application/json' -Body $Body -Headers @{'Authorization' = "Bearer $($WebrootAuthToken.access_token)" }
    }
    catch {
        Write-Error "Error: $($_)"
    }

}