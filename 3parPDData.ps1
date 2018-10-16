$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataPD = Get-3parPD | Select-Object -SkipLast 1
$removessh = ($Connection1 | Remove-SSHSession)
$3parPD = @{}
$dataPD | ForEach-Object {
    $Id = $_.Id
    If (-Not $3parPD.ContainsKey($Id)) {
        $3parPD[$Id] = @{
            "CAGEPOS" = $_.CagePos
            "TYPE" = $_.Type
            "RPM" = $_.RPM
            "STATE" = $_.State
            "TOTAL" = $_.Total
            "FREE" = $_.Free
            "A" = $_.A
            "B" = $_.B
        }
    }
}
$3parPD | ConvertTo-Json -Depth 10