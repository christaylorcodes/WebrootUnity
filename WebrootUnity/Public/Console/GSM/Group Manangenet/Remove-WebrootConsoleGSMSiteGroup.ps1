function Remove-WebrootConsoleGSMSiteGroup {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/DELETE-api-console-gsm-gsmKey-sites-siteId-groups-groupId_newGroupId
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $True)]
        [string]$GSMKey,
        [Parameter(Mandatory = $True)]
        [string]$SiteID,
        [Parameter(Mandatory = $True)]
        [string]$GroupID,
        [string]$NewGroupID
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/groups/$($GroupID)?newGroupId=$($NewGroupID)"

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-RestMethod, with Site: $SiteID and Group: $GroupID")) {
        Connect-WebrootUnity

        try {
            Invoke-RestMethod -Method Delete -Uri $url -ContentType 'application/json' -Headers @{'Authorization' = "Bearer $($WebrootAuthToken.access_token)" }
        }
        catch {
            Write-Error "Error: $($_)"
        }
    }
}