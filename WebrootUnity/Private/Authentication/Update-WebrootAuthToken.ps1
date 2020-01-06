function Update-WebrootAuthToken {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/RefreshTokenAuthentication
        [CmdletBinding()]
        param(
            [Parameter(Mandatory=$True)]
            [string]$client_id,
            [Parameter(Mandatory=$True)]
            [string]$client_secret,        
            [string]$refresh_token = $WebrootAuthToken.refresh_token,
            [string]$scope = '*'    
        )
    
        $url = 'https://unityapi.webrootcloudav.com/auth/token'
    
        $Body = @{refresh_token=$refresh_token;
                  grant_type='refresh_token';
                  scope=$scope}
        
        $Text = "$($client_id):$client_secret"
        $Bytes = [System.Text.Encoding]::ASCII.GetBytes($Text)
        $EncodedText =[Convert]::ToBase64String($Bytes)
    
        try{
            Write-Verbose "Renewing auth token."
            $Obj = Invoke-RestMethod -Method Post -Uri $url -Body $Body -ContentType "application/x-www-form-urlencoded" -Headers @{Authorization = "Basic $EncodedText"}
            $Obj | Add-Member -NotePropertyName 'client_id' -NotePropertyValue $client_id
            $Obj | Add-Member -NotePropertyName 'client_secret' -NotePropertyValue $client_secret
            $Obj | Add-Member -NotePropertyName 'expires' -NotePropertyValue (Get-Date).AddSeconds(295)
            $Obj | Add-Member -NotePropertyName 'Renewable' -NotePropertyValue (Get-Date).AddDays(14).AddSeconds(-5)
            $global:WebrootAuthToken = $Obj | Select * -ExcludeProperty 'expires_in'
            Write-Verbose 'Auth Token saved to $WebrootAuthToken'
        }
        catch{
            Write-Error "ERROR : Please reffer to website for Status Codes. https://unityapi.webrootcloudav.com/Docs/APIDoc/Guide#guide-statusCodes `r`n $_"
        }
    }