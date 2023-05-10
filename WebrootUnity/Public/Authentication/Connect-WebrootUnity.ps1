Function Connect-WebrootUnity {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'New')]
        [string]$client_id,
        [Parameter(Mandatory = $true, ParameterSetName = 'New')]
        [string]$client_secret,
        [Parameter(Mandatory = $true, ParameterSetName = 'New')]
        [pscredential]$credentials,
        [Parameter(ParameterSetName = 'New')]
        [Parameter(ParameterSetName = 'ReNew')]
        [string]$scope = '*',
        [Parameter(ParameterSetName = 'New')]
        [Parameter(ParameterSetName = 'ReNew')]
        [Switch]$force,
        $RenewBuffer = 10
    )

    Write-Verbose 'Connecting'

    #Config file to save token info to
    $configDir = "$Env:AppData\WindowsPowerShell\Modules\WebrootUnity\0.1\Config.ps1xml"

    #If parameter was passed use as new token request
    if ($PSCmdlet.ParameterSetName -eq 'New') {
        Write-Verbose 'Parameters passed, creating new request.'
        Get-WebrootAuthToken -client_id $client_id -client_secret $client_secret -credentials $credentials -scope $scope
    }
    #No parameters where passed use variable or config.
    else {
        #If there is no variable but a config file load
        if (!$WebrootAuthToken -and (Test-Path $configDir) -and !$Force) {
            try {
                $script:WebrootAuthToken = Import-Clixml -Path $configDir -ErrorAction STOP
                if (!$WebrootAuthToken) { stop }
            }
            catch {
                Write-Warning 'Corrupt Password file found, run Connect-WebrootUnity with -Force to fix this.'
                BREAK
            }
            Write-Verbose 'Loaded config file.'
        }

        #Create or Renew the Token if it has expired or does not exist or forced
        if ($WebrootAuthToken.expires -lt (Get-Date).AddSeconds( - [Math]::Abs($RenewBuffer)) -or !$WebrootAuthToken -or $Force) {
            #If it can be renewed and not forced do so
            if ($WebrootAuthToken.Renewable -gt (Get-Date) -and !$Force) {
                Update-WebrootAuthToken -client_id $WebrootAuthToken.client_id -client_secret $WebrootAuthToken.client_secret -refresh_token $WebrootAuthToken.refresh_token
            }
            #Request a new Token
            else {
                Get-WebrootAuthToken -client_id $WebrootAuthToken.client_id -client_secret $WebrootAuthToken.client_secret -credentials $credentials
            }

        }
        else {
            Write-Verbose 'Token still valid.'
        }

    }

    #Create config file if not present.
    if (-not (Test-Path $configDir)) {
        Write-Verbose 'Creating config file.'
        Write-Verbose $configDir
        New-Item -Force -Path "$configDir" -ItemType File | Out-Null
    }

    #store the token
    #TODO secure token
    $WebrootAuthToken | Export-Clixml $configDir -Force
}