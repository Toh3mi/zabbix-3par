$Connection1 = New-3ParPoshSshConnection -SANIPAddress 192.168.1.60 -SANUserName zabbixps -SANPassword Tohemi26@
$dataVVList = Get-3parVVList -SANConnection $Connection1

$3parVVList = @{}
$dataVVList | ForEach-Object {
    $VVname = $_.Name
    If (-Not $3parVVList.ContainsKey($VVname)) {
        $3parVVList[$VVname] = @{
            "Id" = $_.Id
            "Prov" = $_.Prov
            "Usr" = $_.Usr
            "VSize" = $_.VSize
            "Adm" = $_.Adm
            "Snp" = $_.Snp
            "-Detailed_State-" = $_."-Detailed_State-"
            "Rd" = $_.Rd
        }
    }
}
$3parVVList | ConvertTo-Json -Depth 10