# Send-Notification.ps1
# Send a notification using the Simplepush service
#
# Sept 2021
# If this works, Victor Vogelpoel <victor@victorvogelpoel.nl> wrote this.
# If it doesn't, I don't know who wrote this.
#
[CmdletBinding()]
param
( 
	[Parameter(Position=0, Mandatory=$true, HelpMessage="Notification Title")]
    [Alias('Title')]
	[string]$NotificationTitle,

	[Parameter(Position=1, Mandatory=$true, HelpMessage="Notification message")]
    [Alias('Content', 'Message')]
	[string]$NotificationMessage,

	[Parameter(Position=2, Mandatory=$false, HelpMessage="Notification Event")]
    [string]$Event = 'Research',

	[Parameter(Position=2, Mandatory=$false, HelpMessage="Notification Event")]
    [Alias('Key')]
    [string]$SimplePushKey = 'HuxgBB' 
) 


try
{
    # simple GET: Invoke-WebRequest -uri "https://api.simplepush.io/send/HuxgBB/title/message"

    # Alternative via POST
    $notifyParams = @{
        key   = $SimplePushKey
        title = $NotificationTitle
        msg   = $NotificationMessage
        event = $Event
    }

    $response = Invoke-WebRequest -uri "https://api.simplepush.io/send" -Method POST -Body $notifyParams
    #$response

}
catch
{
    # A failing notification should NEVER break the program using it, so no throws here!
    Write-Warning "Notification failed: $($_.Exception)"
}

