function Set-WebrootConsoleGSMSiteGroup {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/POST-api-console-gsm-gsmKey-sites-siteId-groups
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID,
        [Parameter(Mandatory=$True)]
        [string]$GroupID,
        [ValidateSet("Unchanged","All","Update")]
        [string]$Inheritance = "Unchanged",
        [string]$GroupName,
        [string]$GroupDescription,
        [string]$PolicyID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/groups/$($GroupID)"

    switch ($Inheritance){
        'Unchanged'{$Inheritance = 0}
        'All'{$Inheritance = 1}
        'Update'{$Inheritance = 3}
    }

    $Body = @{Inheritance=$Inheritance;
                GroupName=$GroupName;
                GroupDescription=$GroupDescription;
                PolicyID=$PolicyID;}
    $Body = $Body | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-RestMethod, with body:`r`n$Body`r`n")) {
        Connect-WebrootUnity
        Write-Verbose $Body

        try{
            Invoke-RestMethod -Method Put -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        }
        catch{
            Write-Error "Error: $($_)"
        }
    }
}
