function Set-WebrootConsoleGSMSiteUser {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/PUT-api-console-gsm-gsmKey-sites-siteId-admins
    #Can accept a csv of user ID's but only one access level
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID,
        [Parameter(Mandatory=$True)]
        [string]$UserID,
        [Parameter(Mandatory=$True)]
        [ValidateSet("Full","Basic","None")]
        [string]$AccessLevel
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/admins"

    switch ($AccessLevel){
        'Full'  {$AccessLevel = 128}
        'Basic' {$AccessLevel = 1}
        'None'  {$AccessLevel = 0}
    }

    $List = foreach($ID in $UserID){
        [PSCustomObject]@{
            UserId = $ID
            AccessLevel = $AccessLevel
        }
    }

    $Body = @{
        Admins = $List
    } | ConvertTo-Json
    <#
    $List = $(($List | ConvertTo-Json).trim('[]'))
    $Body = @"
{
    'Admins': [
        $List
    ]
}
"@
    #>

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