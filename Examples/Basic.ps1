# Authenticate
# https://github.com/christaylorcodes/WebrootUnity/wiki/Getting-Started

# Provide your webroot management console user/password
$Credentials = Get-Credential -Message 'Webroot management console'

# Your 'Parent Keycode' refereed to as the GSMKey in this module
$GSMKey = 'SAF1-LTSW-94E7-C6BA-ABED'

# Splat our connection parameters
$WebrootConnectionInfo = @{
    client_id     = 'client_92sLyHYa@christaylor.codes'
    client_secret = 'h_e4vY2\wCtI%dn'
    # ^ This is the information created under 'API Access'
    credentials   = $Credentials
}

Connect-WebrootUnity @WebrootConnectionInfo

# Now that we are connected lets get a list of our sites
$Sites = Get-WebrootConsoleGSMSiteList -GSMKey $GSMKey

# Lets look at the endpoints in a site
Get-WebrootConsoleGSMSiteEndpointList -GSMKey $GSMKey -SiteId $Sites.Sites[0].SiteID -All