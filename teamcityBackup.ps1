<# Version: 0.1
   License: GPLv2 (https://www.gnu.org/licenses/gpl-2.0.txt)
   Author: Nirmal Pathak.
   Purpose: PS script to backup TeamCity databases & config running on Windows OS.
#>

#Add your credentials.
$user = "username"
$pass= "password"

$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($user, $secpasswd)

#Basic Backup of TeamCity server.
#Invoke-RestMethod -Uri  "http://172.16.1.32:81/httpAuth/app/rest/server/backup?includeConfigs=true&includeDatabase=true&includeBuildLogs=true&fileName=TeamCity_Backup" -Method Post -Credential $cred

#All Backup of TeamCity Server.
Invoke-RestMethod -Uri  "http://192.168.2.129:90/httpAuth/app/rest/server/backup?addTimestamp=true&includeConfigs=true&includeDatabase=true&includeBuildLogs=true&includePersonalChanges=true&fileName=TeamCity_Backup" -Method Post -Credential $cred
