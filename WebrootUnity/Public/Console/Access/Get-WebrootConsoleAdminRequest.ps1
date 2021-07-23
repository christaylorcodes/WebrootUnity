function Get-WebrootConsoleAdminRequest {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-access-gsm-gsmKey-addadminstatus_userEmail_confirmEmail
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey,
        [Parameter(Mandatory=$True)]
        $UserEmail,
        [Parameter(Mandatory=$True)]
        $ConfirmEmail
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/access/gsm/$($GSMKey)/addadminstatus?userEmail=$($UserEmail)&confirmEmail=$($ConfirmEmail)"

    Connect-WebrootUnity

    try{
        $obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
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
        Write-Error "Error: $($_)"
    }
}