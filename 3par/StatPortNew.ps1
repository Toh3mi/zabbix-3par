$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass.1" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$data = Get-3parStatPort -SANConnection $Connection1 -Iteration 1
$removessh = ($Connection1 | Remove-SSHSession)
$3parStatPort = @{}
$data | ForEach-Object {
    $portname = $_.Port
    If (-Not $3parStatPort.ContainsKey($portname)) {
        $3parStatPort[$portname] = @{
            "KBCur" = $_.KB_Cur
            "SvtCur" = $_.Svt_Cur
            "IOCur" = $_."I/O_Cur"
            "IOSzCur" = $_.IOSz_Cur
        }
    }
}
$3parStatPort | ConvertTo-Json -Depth 10