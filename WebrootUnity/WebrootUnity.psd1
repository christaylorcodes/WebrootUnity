#
# Module manifest for module 'WebrootUnity'
#
# Generated by: Chris Taylor
#
# Generated on: 1/5/2020
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'WebrootUnity.psm1'

    # Version number of this module.
    ModuleVersion = '0.1.9.0'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID              = 'e1394e34-20ec-4067-8b45-8e39815a1645'

    # Author of this module
    Author            = 'Chris Taylor'

    # Company or vendor of this module
    CompanyName       = 'ChrisTaylorCodes'

    # Copyright statement for this module
    Copyright         = '(c) 2023 Chris Taylor. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'PowerShell module to interface with the Webroot Unity API'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '3.0'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = 'WebrootUnity.Format.ps1xml'

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('Connect-WebrootUnity','Get-WebrootConsoleAdminRequest','New-WebrootConsoleAdminRequest','Get-WebrootConsoleGSMCommandList','Get-WebrootConsoleGSMEndpointCommandList','Get-WebrootConsoleGSMGroupCommandList','New-WebrootConsoleGSMEndpointCommand','New-WebrootConsoleGSMEndpointGroupCommand','Disable-WebrootConsoleGSMEndpoint','Disable-WebrootConsoleGSMEndpointGroup','Enable-WebrootConsoleGSMEndpoint','Get-WebrootConsoleGSMGroupEndpointList','Get-WebrootConsoleGSMSiteEndpoint','Get-WebrootConsoleGSMSiteEndpointList','Set-WebrootConsoleGSMEndpointGroup','Set-WebrootConsoleGSMEndpointPolicy','Set-WebrootConsoleGSMGroupPolicy','Get-WebrootConsoleGSMSiteGroup','Get-WebrootConsoleGSMSiteGroupList','New-WebrootConsoleGSMSiteGroup','Remove-WebrootConsoleGSMSiteGroup','Set-WebrootConsoleGSMSiteGroup','Get-WebrootConsoleGSMPolicy','Get-WebrootConsoleGSMPolicyList','Get-WebrootConsoleGSMSitePolicy','Get-WebrootConsoleGSMSitePolicyList','Convert-WebrootConsoleGSMSite','Get-WebrootConsoleGSMSite','Get-WebrootConsoleGSMSiteList','Get-WebrootConsoleGSMSiteUser','Get-WebrootConsoleGSMSiteUserList','New-WebrootConsoleGSMSite','Remove-WebrootConsoleGSMSite','Resume-WebrootConsoleGSMSite','Suspend-WebrootConsoleGSMSite','Update-WebrootConsoleGSMSite','Get-WebrootConsoleGSMEndpointThreatList','Get-WebrootConsoleGSMGroupThreatList','Get-WebrootConsoleGSMThreatList','Get-WebrootConsoleGSMUser','Get-WebrootConsoleGSMUserList','Set-WebrootConsoleGSMSiteUser','Get-WebrootHealthCheckPing','Get-WebrootHealthCheckVersion','Get-WebrootEndpointStatus','Get-WebrootEndpointStatusGSM','Get-WebrootKeycodeUsage')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = @('')

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashTable with additional module metadata used by PowerShell.
    PrivateData       = @{
        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('Webroot', 'Unity', 'REST', 'API', 'Antivirus', 'ChrisTaylorCodes')

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/christaylorcodes/WebrootUnity/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/christaylorcodes/WebrootUnity'

            # A URL to an icon representing this module.
            IconUri      = 'https://www.webroot.com/blog/wp-content/uploads/2014/12/W-Circle-logo_color.png'

            # ReleaseNotes of this module
            ReleaseNotes = 'https://github.com/christaylorcodes/WebrootUnity/releases'

        } # End of PSData hashTable

    } # End of PrivateData hashTable

    # HelpInfo URI of this module
    HelpInfoURI       = 'https://raw.githubusercontent.com/christaylorcodes/WebrootUnity/master/WebrootUnity/en-US/WebrootUnity-help.xml'

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}
