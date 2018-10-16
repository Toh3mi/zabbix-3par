$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataVlun = Get-3parHostPorts | Select-Object -SkipLast 1
$removessh = ($Connection1 | Remove-SSHSession)

$data = @()

$dataVlun | ForEach-Object {

    $3parexport = @{}

    $3parexport["{#DEVICE}"] = $_.Device
    $3parexport["{#MODE}"] = $_.Mode
    $3parexport["{#STATE}"] = $_.State
    $3parexport["{#NODEWWN}"] = $_.Node_WWN
    $3parexport["{#PORTWWN}"] = $_.Port_WWN
    $3parexport["{#TYPE}"] = $_.Type
    $3parexport["{#PROTOCOL}"] = $_.Protocol
    $3parexport["{#LABEL}"] = $_.Label
    $3parexport["{#PARTNER}"] = $_.Partner

    
    $data += $3parexport

}

$exportdata = @{}
$exportdata["data"] = $data

$exportdata | ConvertTo-Json -Depth 10 -Compress