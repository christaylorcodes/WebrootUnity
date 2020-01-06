$Verbose = @{}
if($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master")
{
    $Verbose.add("Verbose",$True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module $PSScriptRoot\..\WebrootUnity\WebrootUnity.psm1 -Force

#Integration test example
Describe "Get-WebrootHealthCheckVersion  PS$PSVersion Integrations tests" {

    Context 'Strict mode' { 

        Set-StrictMode -Version latest

        It 'should get valid data' {
            $Output = Get-WebrootHealthCheckVersion 
            $Output.Name -eq 'Webroot.UnityAPI.APIServer'
            $Output.Version -eq '1.0.0.0'
        }
    }
}