$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataVlun = Get-3parStatVlun -SANConnection $Connection1 -Iteration 1
$removessh = ($Connection1 | Remove-SSHSession)

$data = @()

$dataVlun | ForEach-Object {

    $3parexport = @{}

    $3parexport["{#NAMEVLUN}"] = $_.Host+$_.Port+$_.VVName
    
    $data += $3parexport

}

$exportdata = @{}
$exportdata["data"] = $data

$exportdata | ConvertTo-Json -Depth 10