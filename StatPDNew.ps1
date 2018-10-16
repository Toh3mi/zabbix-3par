$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$data = Get-3parstatPD -SANConnection $Connection1 -Iteration 1
$removessh = ($Connection1 | Remove-SSHSession)
$3parPort = @{}

$data | ForEach-Object {
    $diskid = $_.ID
    If (-Not $3parPort.ContainsKey($diskid)) {
        $3parPort[$diskid] = @{
            "KBCur" = $_.KB_Cur
            "SvtCur" = $_.Svt_Cur
            "IOSzCur" = $_.IOSz_Cur
            "IdleCur" = $_.Idle_Cur
            "IOCur" = $_."I/O_Cur"
            "Port" = $_.Port
        }
        
    }

}
$3parPort | ConvertTo-Json -Depth 10
