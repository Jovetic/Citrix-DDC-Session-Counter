Function Send-SlackMessage{

    Param(
            [parameter(Mandatory=$True,ValueFromPipeLine=$True)]
            [string]$Text,
            [parameter(Mandatory=$True)]
            [string]$Webhook)
    
        $payload = @{
        "icon_emoji" = ":Information_source:"
        "text" = "$Text"
                    }
    
    Invoke-WebRequest -Body (ConvertTo-Json -Compress -InputObject $payload) -Method Post -Uri $Webhook | Out-Null
                               
    }