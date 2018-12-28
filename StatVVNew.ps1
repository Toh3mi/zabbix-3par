$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass.1.1" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataVV = Get-3parStatVV -SANConnection $Connection1 -Iteration 1
$removessh = ($Connection1 | Remove-SSHSession)
$3parStatVV = @{}
$3parStatVV = @{}
$dataVV | ForEach-Object {
    $VVname = $_.VVname
    If (-Not $3parStatVV.ContainsKey($VVname)) {
        $3parStatVV[$VVname] = @{
            "KBCUR" = $_.KB_Cur
            "SVTCUR" = $_.Svt_Cur
            "IOSZCUR" = $_.IOSz_Cur
            "IOCUR" = $_."I/O_Cur"
        }
    }
}
$3parStatVV | ConvertTo-Json -Depth 10