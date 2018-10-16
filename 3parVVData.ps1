$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataVVList = Get-3parVVList
$removessh = ($Connection1 | Remove-SSHSession)
$3parVVList = @{}
$dataVVList | ForEach-Object {
    $VVname = $_.Name
    If (-Not $3parVVList.ContainsKey($VVname)) {
        $3parVVList[$VVname] = @{
            "ID" = $_.Id
            "PROV" = $_.Prov
            "USED" = $_.Usr
            "TOTAL" = $_.VSize
            "ADM" = $_.Adm
            "SNP" = $_.Snp
            "STATE" = $_."-Detailed_State-"
            "RD" = $_.Rd
        }
    }
}
$3parVVList | ConvertTo-Json -Depth 10