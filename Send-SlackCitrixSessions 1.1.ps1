Function Send-SlackCitrixSessions{

$Data = Get-DDCServerSessions

$SlackText = @()
        ForEach ($line in $Data){
Try{
        $A=$Line.Sessions
        $B=$Line.Computer
        $C=$Line.Active
        $D=$Line.Disconnected
        $E=$Line.Stale
}Catch{
}Finally{
        $SlackText += "*$A* Sessions on *$B*, *$C* Active, *$D* Disconnected. *$E* of which have been disconnected more than *10* days"
}
}
Write-Output $SlackText
}



