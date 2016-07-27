# Version: 0.1
<# Version: 0.1
   License: GPLv2 (https://www.gnu.org/licenses/gpl-2.0.txt)
   Author: Nirmal Pathak.
   Credit: http://www.powershellmagazine.com/2013/03/29/pstip-detecting-if-a-certain-process-is-elevated/
   Purpose: PS script to get elevated state of process.
#>

function Elevated {
	$PROCESS="explorer.exe"
	$PCOUNT=(ps $PROCESS).count 2> $null
	if ($PCOUNT -eq 0) {
	#	If no process is running then store vale as false.
		write-output "False" > C:\zabbix_agents_3.0.0.win\result.txt
		write-output "$(date; whoami) - $PROCESS is not running." >> C:\zabbix_agents_3.0.0.win\script-log.txt
	}
	elseif ($PCOUNT -eq 1) {
	#	If only one process is running, then check if it is running in 'Elevated' mode.
		$RESULT=Get-Process -name $PROCESS | Add-Member -Name Elevated -MemberType ScriptProperty -Value {if ($this.Name -in @('Idle','System')) {$null} else {-not $this.Path -and -not $this.Handle} } -PassThru | Select-Object -ExpandProperty Elevated
		write-output $RESULT > C:\zabbix_agents_3.0.0.win\result.txt
		write-output "$(date; whoami) - Only $PCOUNT $PROCESS process is running." >> C:\zabbix_agents_3.0.0.win\script-log.txt
	}
	else {
	#	If Multiple processes are running, then check if any process is running in 'Non-Elevated' mode. Find 'False' value from array & store result as 'False'.
		$RESULT=Get-Process -name $PROCESS | Add-Member -Name Elevated -MemberType ScriptProperty -Value {if ($this.Name -in @('Idle','System')) {$null} else {-not $this.Path -and -not $this.Handle} } -PassThru | Select-Object -ExpandProperty Elevated
		if ($RESULT -contains "False") {
			write-output "False" > C:\zabbix_agents_3.0.0.win\result.txt
		}
		write-output "$(date; whoami) - $PCOUNT numbers of $PROCESS processes are running." >> C:\zabbix_agents_3.0.0.win\script-log.txt
	}
}

#Run the function
Elevated
