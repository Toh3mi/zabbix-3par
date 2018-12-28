$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataVlun = Get-3parstatPD -SANConnection $Connection1 -Iteration 1
$removessh = ($Connection1 | Remove-SSHSession)

$data = @()

$dataVlun | ForEach-Object {

    $3parexport = @{}

    $3parexport["{#DISKID}"] = $_.ID
    $3parexport["{#PORTCAGE}"] = $_.Port
    
    $data += $3parexport

}

$exportdata = @{}
$exportdata["data"] = $data

$exportdata | ConvertTo-Json -Depth 10 -Compress