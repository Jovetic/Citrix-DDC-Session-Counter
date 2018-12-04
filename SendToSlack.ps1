Send-SlackMessage -Text (Get-DDCServerSessions -Computername "SERVER","SERVER01"|Out-String) -Webhook "https://hooks.slack.com/services/YOURWEBHOOKURI"

Send-SlackMessage -Text ((Get-Content C:\scripts\Citrix\Private\Computers.txt)|Get-DDCServerSessions|Out-string) -Webhook "https://hooks.slack.com/services/YOURWEBHOOKURI"

Send-SlackMessage -Text (Send-SlackCitrixSessions|Out-String) -Webhook "https://hooks.slack.com/services/YOURWEBHOOKURI"