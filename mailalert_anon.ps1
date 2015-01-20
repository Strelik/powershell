


#author The Strelik

#Summary: Email notification script that you can run via task scheduler to notifiy you about services, login attempts etc. 




#######################################################
#Global Variables




######################################################
#Functions

#You can can copy and pasta some code here in a function block that you can pass to the main function parameter below. See the commented example.
function some_task{

Get-Service | ? status -eq Stopped | Out-String       #Remember if you're working with Powershell objects to output eveything as a human readable string. 

}




#Function that accepts some kind of parameter via $args to include in an email notification message utilizing Google's SMTP servers.
function notify{

#Define some variables for needed to authenticate with Google's SMTP servers. 

#Message related variables
$EMAILFrom = "alerts@somedomain.com"
$EMAILTo = ""
$SUBJECT = "ALERT"
$Body = $args

#Google SMTP Variables. Basically all variables add up to creating a SMTP connection to Google's servers and you just pass through your $args into the body of the message.
$SMTPSERVER = "smtp.gmail.com"
$SMTPCLIENT = New-Object Net.Mail.SmtpClient($SMTPSERVER, 587)
$SMTPCLIENT.EnableSsl = $true
$SMTPCLIENT.Credentials = New-Object System.Net.NetworkCredential("user", (Get-Content C:\path\to\creds.txt)) #Probably want to pass this through a read protected file. Otherwise replace Get-Content with your passsword string if you must.
$SMTPCLIENT.Send($EMAILFrom, $EMAILTo, $SUBJECT, $Body)


}

$x = some_task

#Finally Simply pass your task as an parameter into the notify script
notify $x



######################################################