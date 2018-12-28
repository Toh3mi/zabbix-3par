$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$data = Get-3parPD
$removessh = ($Connection1 | Remove-SSHSession)
$3parStatePD = @{}

$data | ForEach-Object {
    $diskid = $_.Id
    If (-Not $3parStatePD.ContainsValue($diskid)) {
        $3parStatePD[$diskid] = @{
            "CagePos" = $_.CagePos
            "Type" = $_.Type
            "RPM" = $_.RPM
            "State" = $_.State
            "Total" = $_.Total
            "Free" = $_."Free"
        }
        
    }

}
$3parStatePD | ConvertTo-Json -Depth 10