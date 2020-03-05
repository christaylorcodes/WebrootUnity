function Set-WebrootConsoleGSMEndpointPolicy {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/PUT-api-console-gsm-gsmKey-sites-siteId-endpoints-policy
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID,
        [string]$EndpointsList,
        [Parameter(Mandatory=$True)]
        [string]$PolicyId
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/endpoints/policy"

    $Body = @{EndpointsList=$EndpointsList;
                PolicyId=$PolicyId;}
    $Body = $Body | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-RestMethod, with body:`r`n$Body`r`n")) {
        Connect-WebrootUnity
        Write-Verbose $Body

        try{
            Invoke-RestMethod -Method Put -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        }
        catch{
            Write-Error "Error: $($Error[0])"
        }
    }
}