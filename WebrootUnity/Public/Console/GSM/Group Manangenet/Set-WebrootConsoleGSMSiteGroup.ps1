function Set-WebrootConsoleGSMSiteGroup {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/POST-api-console-gsm-gsmKey-sites-siteId-groups
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $True)]
        [string]$GSMKey,
        [Parameter(Mandatory = $True)]
        [string]$SiteID,
        [Parameter(Mandatory = $True)]
        [string]$GroupID,
        [ValidateSet('Unchanged', 'All', 'Update')]
        [string]$Inheritance = 'Unchanged',
        [string]$GroupName,
        [string]$GroupDescription,
        [string]$PolicyID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/groups/$($GroupID)"

    switch ($Inheritance) {
        'Unchanged' { $InheritanceInt = 0 }
        'All' { $InheritanceInt = 1 }
        'Update' { $InheritanceInt = 3 }
    }

    $Body = @{
        Inheritance      = [int]$InheritanceInt
        GroupName        = $GroupName
        GroupDescription = $GroupDescription
        PolicyID         = $PolicyID
    } | ConvertTo-Json
    Write-Verbose $Body

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-RestMethod, with body:`r`n$Body`r`n")) {
        Connect-WebrootUnity

        try {
            Invoke-RestMethod -Method Put -Uri $url -ContentType 'application/json' -Body $Body -Headers @{'Authorization' = "Bearer $($WebrootAuthToken.access_token)" }
        }
        catch {
            Write-Error "Error: $($_)"
        }
    }
}
