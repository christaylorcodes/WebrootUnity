function Get-WebrootAuthToken {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/PasswordAuthentication
        [CmdletBinding()]
        param(
            [Parameter(Mandatory=$True)]
            [string]$client_id,
            [Parameter(Mandatory=$True)]
            [string]$client_secret,
            [string]$username,
            [string]$password,
            [string]$scope = '*'    
        )
    
        $url = 'https://unityapi.webrootcloudav.com/auth/token'
    
        if(!$username -or !$password){
            Write-Verbose "Credentials not passed, prompting."
            $Credentials = Get-Credential -Message "Webroot SecureAnywhere GSM" -UserName $username
            $username = $Credentials.UserName
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Credentials.Password)
            $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
        }
    
        $Body = @{username=$username;
                  password=$password;
                  grant_type='password';
                  scope=$scope}
    
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
            $global:WebrootAuthToken = $Obj | Select * -ExcludeProperty 'expires_in'
            Write-Verbose 'Auth Token saved to $WebrootAuthToken'
        }
        catch{
            Write-Error "ERROR : Please reffer to website for Status Codes. https://unityapi.webrootcloudav.com/Docs/APIDoc/Guide#guide-statusCodes `r`n $_"
        }
    }