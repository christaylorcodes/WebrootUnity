function Get-WebrootConsoleGSMUser {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-admins-userId
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey,
        [Parameter(Mandatory=$True)]
        $UserID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/admins/$($UserID)"
    
    Write-Verbose "Connecting"
    Connect-WebrootUnity
            
    try{
        $Obj =Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        $Obj.Admins
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }
    
}