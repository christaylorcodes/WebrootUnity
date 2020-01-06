function Set-WebrootConsoleGSMSiteUser {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/PUT-api-console-gsm-gsmKey-sites-siteId-admins
    #Can accept a csv of user ID's but only one access level
    [CmdletBinding()]
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
        $object = New-Object -TypeName PSObject
        $object | Add-Member -MemberType NoteProperty -Name UserId -Value $ID
        $object | Add-Member -MemberType NoteProperty -Name AccessLevel -Value $AccessLevel
        Write-Output $object
    }

    $List = $(($List | ConvertTo-Json).trim('[]'))

    $Body = @"
{
    'Admins': [
        $List
    ]
}
"@

    Write-Verbose 'Connecting'
    Connect-WebrootUnity
            
    try{
        Invoke-RestMethod -Method Put -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }
    
}