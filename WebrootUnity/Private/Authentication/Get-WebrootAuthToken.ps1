function Get-WebrootAuthToken {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/PasswordAuthentication
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$client_id,
        [Parameter(Mandatory=$True)]
        [string]$client_secret,
        [Parameter(Mandatory=$True)]
        [pscredential]$credentials,
        [string]$scope = '*'    
    )

    $url = 'https://unityapi.webrootcloudav.com/auth/token'

    $Body = @{
        username    = $credentials.UserName
        password    = $credentials.GetNetworkCredential().Password
        grant_type  = 'password'
        scope       = $scope
    }

    $Auth = "$($client_id):$client_secret"
    $Bytes = [System.Text.Encoding]::ASCII.GetBytes($Auth)
    $Auth =[Convert]::ToBase64String($Bytes)

    try{
        Write-Verbose "Getting auth token."
        $Obj = Invoke-RestMethod -Method Post -Uri $url -Body $Body -ContentType "application/x-www-form-urlencoded" -Headers @{Authorization = "Basic $Auth"}
        $Obj | Add-Member -NotePropertyName 'client_id' -NotePropertyValue $client_id
        $Obj | Add-Member -NotePropertyName 'client_secret' -NotePropertyValue $client_secret
        $Obj | Add-Member -NotePropertyName 'expires' -NotePropertyValue (Get-Date).AddSeconds(295)
        $Obj | Add-Member -NotePropertyName 'Renewable' -NotePropertyValue (Get-Date).AddDays(14).AddSeconds(-5)
        $script:WebrootAuthToken = $Obj | Select-Object * -ExcludeProperty 'expires_in'
        Write-Verbose 'Auth Token saved to $WebrootAuthToken'
    }
    catch{
        Write-Error "ERROR : Please refer to website for Status Codes. https://unityapi.webrootcloudav.com/Docs/APIDoc/Guide#guide-statusCodes `r`n $_"
    }
}