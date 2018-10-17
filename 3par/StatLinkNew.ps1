$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataLink = Get-3parStatLink -SANConnection $Connection1 -Iteration 1
$removessh = ($Connection1 | Remove-SSHSession)
$3parStatLink = @{}
$3parStatLink["#NODE3PAR"] = @{}

$dataLink | ForEach-Object {
    $nodeLink = $_.Node

    If (-Not $3parStatLink["#NODE3PAR"].ContainsKey($nodeLink)) {
        $3parStatLink["#NODE3PAR"][$nodeLink] = @{}
        $3parStatLink["#NODE3PAR"][$nodeLink]["#HARDWARE"] = @{}
    }

    $3parStatLink["#NODE3PAR"][$nodeLink]["#HARDWARE"][$_.Q] = @{
        "#KB_CUR" = $_.KB_Cur
        "#TONODE" = $_.ToNode
        "#XCB_CUR" = $_.XCB_Cur
        "#XCBSZ_KB_CUR" = $_.XCBSz_KB_Cur
    }
}
$3parStatLink | ConvertTo-Json -Depth 10