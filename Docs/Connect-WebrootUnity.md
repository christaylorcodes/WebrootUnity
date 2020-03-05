---
external help file: WebrootUnity-help.xml
Module Name: WebrootUnity
online version:
schema: 2.0.0
---

# Connect-WebrootUnity

## SYNOPSIS
This will connect you to the Webroot Unity API.

## SYNTAX

### New
```
Connect-WebrootUnity [-client_id] <String> [-client_secret] <String> -credentials <PSCredential>
 [[-scope] <String>] [-force] [<CommonParameters>]
```

### ReNew
```
Connect-WebrootUnity [[-scope] <String>] [-force] [<CommonParameters>]
```

## DESCRIPTION
This handle all the authentication for the module.

## EXAMPLES

### Example 1
```powershell
Connect-WebrootUnity -client_id 'client_123' -client_secret 'penguin' -credentials Get-Credential
```

This is will attempt to connect the Unity API.

## PARAMETERS

### -client_id
Generated from GSM Settings, [API Access](https://my.webrootanywhere.com/gsm.aspx#page_tab_account_apiaccess)

```yaml
Type: String
Parameter Sets: New
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -client_secret
Generated from GSM Settings, [API Access](https://my.webrootanywhere.com/gsm.aspx#page_tab_account_apiaccess)

```yaml
Type: String
Parameter Sets: New
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -force
Overwrite cached information

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -scope
{{ Fill scope Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -credentials
[PSCredential] object with your GSM user name and password.

```yaml
Type: PSCredential
Parameter Sets: New
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Get Access Token](https://unityapi.webrootcloudav.com/Docs/en/APIDoc/GettingStarted#gettingStarted-acquireCredentials)