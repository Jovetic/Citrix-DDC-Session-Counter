﻿Function Get-DDCServerSessions{

    [cmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,
                   ValueFromPipeLine=$True,
                   ValueFromPipeLineByPropertyName=$True,
                   HelpMessage="The Citrix Delivery Controller you want to Query.  Accepts Multiple Servers.")]
        [Alias('Hostname','cn','name')]                 
        [String[]]$Computername)

    BEGIN {}
    PROCESS {
            ForEach ($Computer in $ComputerName){
                Try{
            
                    $Session = New-PSSession -ComputerName $Computer -ErrorAction Stop
                    $Cou = Invoke-Command -Session $Session {Add-PSSnapin Citrix*;Get-BrokerSession}
                    $Act = $Cou|Where-Object{$_.SessionState -eq 'Active'}
                    $Dis = $Cou|Where-Object{$_.SessionState -eq 'Disconnected'}
                    $Old = $Dis|Where-Object{$_.StartTime -lt (Get-Date).AddDays(-10)}
                    
                    $Properties =[ordered] @{Computer    = $Computer
                                            Sessions     = $Cou.Count
                                            Active       = $Act.Count
                                            Disconnected = $Dis.Count
                                            Stale        = $Old.Count}
                }Catch{
                    Write-Verbose "Couldn't connect to $Session"
                    $Properties =[ordered] @{Computer    = $Computer
                                            Sessions     = $null
                                            Active       = $null
                                            Disconnected = $null
                                            Stale        = $null
                                            Status       = 'Not available'}

                }Finally {       
                    $AllSessions = New-Object -TypeName PSObject -Property $Properties
                    $AllSessions.psobject.typenames.insert(0,'Citrix.Sessions.Object')
                    Write-Output $AllSessions
                }   
            }
        }
    END {}
   }

