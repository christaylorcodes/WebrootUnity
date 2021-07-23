function Get-WebrootConsoleGSMPolicyList {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-policies
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/policies"

    Write-Verbose "Connecting"
    Connect-WebrootUnity

    try{
        $obj = Invoke-RestMethod -Method Get -Uri $url -ContentType "application/json" -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
        $obj.Policies
    }
    catch{
        Write-Error "Error: $($_)"
    }

}