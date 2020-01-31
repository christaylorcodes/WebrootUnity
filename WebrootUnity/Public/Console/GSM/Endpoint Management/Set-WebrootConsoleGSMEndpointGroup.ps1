function Set-WebrootConsoleGSMEndpointGroup {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/PUT-api-console-gsm-gsmKey-sites-siteId-endpoints
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID,
        [string]$EndpointsList,
        [string]$SourceGroupId,
        [Parameter(Mandatory=$True)]
        [string]$TargetGroupId,
        [ValidateSet("Unchanged","All","Update")] 
        [string]$Inheritance = "Unchanged"
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/endpoints"

    switch ($Inheritance){
        'Unchanged'{$Inheritance = 0}
        'All'{$Inheritance = 1}
        'Update'{$Inheritance = 3}
    }
    
    $Body = @{EndpointsList=$EndpointsList;
                SourceGroupId=$SourceGroupId;
                TargetGroupId=$TargetGroupId;
                Inheritance=$Inheritance;}
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