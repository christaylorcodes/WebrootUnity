function New-WebrootConsoleGSMEndpointCommand {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/POST-api-console-gsm-gsmKey-sites-siteId-endpoints-commands    
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID,
        [string]$EndpointsList,
        [Parameter(Mandatory=$True)]
        [ValidateSet("scan","cleanup","uninstall","changekeycode","restart")]
        [string]$Command,
        [string]$Parameters
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/endpoints/commands"
    
    $Body = @{EndpointsList=$EndpointsList;
                Command=$Command;
                Parameters=$Parameters;}
    $Body = $Body | ConvertTo-Json


    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-RestMethod, with body:`r`n$Body`r`n")) {

        Connect-WebrootUnity
                
        try{
            Invoke-RestMethod -Method Post -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        }
        catch{
            Write-Error "Error: $($Error[0])"
        }
    }
}