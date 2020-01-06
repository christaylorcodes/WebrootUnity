function New-WebrootConsoleAdminRequest {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/POST-api-console-access-gsm-gsmKey-addadminrequest
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey,
        [Parameter(Mandatory=$True)]
        $UserEmail,
        [Parameter(Mandatory=$True)]
        $ConfirmEmail
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/access/gsm/$($GSMKey)/addadminrequest"
    
    $Body = @{UserEmail=$UserEmail;
                ConfirmEmail=$ConfirmEmail;}
    $Body = $Body | ConvertTo-Json


    Write-Verbose "Connecting"
    Connect-WebrootUnity
            
    try{
        $obj = Invoke-RestMethod -Method Post -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        $Obj.QueryResults
        if($All){
            while($Obj.ContinuationURI){
                Connect-WebrootUnity
                $Obj = Invoke-RestMethod -Method Get -uri $Obj.ContinuationURI -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
                $Obj.QueryResults
            }
        }
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }
    
}