$Verbose = @{}
if($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master")
{
    $Verbose.add("Verbose",$True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module $PSScriptRoot\..\WebrootUnity\WebrootUnity.psm1 -Force

Describe "Get-WebrootHealthCheckVersion  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'should get valid data' {
            $Output = Get-WebrootHealthCheckVersion
            $Output.Name -eq 'Webroot.UnityAPI.APIServer'
            $Output.Version | Should -Be '1.0.0.0'
        }
    }
}

Describe "Connect-WebrootUnity  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest
        It 'should connect' {
            $Password = ConvertTo-SecureString -AsPlainText -Force $env:Password
            $Credentials = New-Object PSCredential $env:UserName, $Password

            $ConnectionInfo = @{
                'client_id' = $env:CLIENT_ID
                'client_secret' = $env:CLIENT_SECRET
                'credentials' = $Credentials
            }

            $Output = Connect-WebrootUnity @ConnectionInfo
        }
    }
}