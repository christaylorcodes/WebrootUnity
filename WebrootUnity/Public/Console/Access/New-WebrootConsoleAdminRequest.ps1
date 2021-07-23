function New-WebrootConsoleAdminRequest {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/POST-api-console-access-gsm-gsmKey-addadminrequest
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey,
        [Parameter(Mandatory=$True)]
        $UserEmail,
        [Parameter(Mandatory=$True)]
        $ConfirmEmail
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/access/gsm/$($GSMKey)/addadminrequest"

    $Body = @{
        UserEmail = $UserEmail
        ConfirmEmail = $ConfirmEmail
    } | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($url, "Invoke-RestMethod, with body:`r`n$Body`r`n")) {
        Connect-WebrootUnity
        try{
            $Obj = Invoke-RestMethod -Method Post -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
            $Obj.QueryResults
        }
        catch{
            Write-Error "Error: $($_)"
        }
    }
}