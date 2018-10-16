$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$datastatvv = (Get-3parStatVV -SANConnection $Connection1 -Iteration 1)
$removessh = ($Connection1 | Remove-SSHSession)
$datastatvv | ConvertTo-Json