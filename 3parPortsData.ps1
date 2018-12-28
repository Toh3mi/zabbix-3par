$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataVlun = Get-3parHostPorts | Select-Object -SkipLast 1
$removessh = ($Connection1 | Remove-SSHSession)

$3parStatPort = @{}
$dataVlun | ForEach-Object {
    $portname = $_.Device
    If (-Not $3parStatPort.ContainsKey($portname)) {
        $3parStatPort[$portname] = @{
            "MODE" = $_.Mode
            "STATE" = $_.State
            "NODEWWN" = $_.Node_WWN
            "PORTWWN" = $_.Port_WWN
            "TYPE" = $_.Type
            "PROTOCOL" = $_.Protocol
            "LABEL" = $_.Label
            "PARTNER" = $_.Partner
        }
    }
}
$3parStatPort | ConvertTo-Json -Depth 10