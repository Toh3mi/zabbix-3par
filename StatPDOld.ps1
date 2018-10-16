$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$data = Get-3parstatPD -SANConnection $Connection1 -Iteration 1
$removessh = ($Connection1 | Remove-SSHSession)
$3parPort = @{}
$3parPort["#CAGEPORT"] = @{}
$data | ForEach-Object {
    $portname = $_.Port
    If (-Not $3parPort["#CAGEPORT"].ContainsKey($portname)) {
        $3parPort["#CAGEPORT"][$portname] = @{}
        $3parPort["#CAGEPORT"][$portname]["#DISKID"] = @{}
    }
    $3parPort["#CAGEPORT"][$portname]["#DISKID"][$_.ID] = @{
        "#KBCur" = $_.KB_Cur
        "#SvtCur" = $_.Svt_Cur
        "#IOSzCur" = $_.IOSz_Cur
        "#IdleCur" = $_.Idle_Cur
        "#IOCur" = $_."I/O_Cur"
    }
}
$3parPort | ConvertTo-Json -Depth 10
