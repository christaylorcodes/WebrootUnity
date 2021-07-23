function Get-WebrootConsoleGSMPolicy {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/GET-api-console-gsm-gsmKey-policies-policyId
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $GSMKey,
        [Parameter(Mandatory=$True)]
        $PolicyID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/policies/$($PolicyID)"

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
