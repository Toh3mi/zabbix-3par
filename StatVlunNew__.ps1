$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataVlun = Get-3parStatVlun -SANConnection $Connection1 -Iteration 1
$removessh = ($Connection1 | Remove-SSHSession)
$3parexport = @{}
$3parexport["{#VIRTHOST}"] = @{}
$dataVlun | ForEach-Object {
    $exportport = $_.Host
    If (-Not $3parexport["{#VIRTHOST}"].ContainsKey($exportport)) {
        $3parexport["{#VIRTHOST}"][$exportport] = @{}
        $3parexport["{#VIRTHOST}"][$exportport]["{#NAMEPORT}"] = @{}
    }
    $3parvlun = $_
        $dataVlun | ForEach-Object {
            If (-Not $3parexport["{#VIRTHOST}"].ContainsKey($_.VVName)) {

                If(-Not $3parexport["{#VIRTHOST}"][$exportport]["{#NAMEPORT}"].ContainsKey($_.Port)) {
                    $3parexport["{#VIRTHOST}"][$exportport]["{#NAMEPORT}"][$_.Port] = @{}
                    $3parexport["{#VIRTHOST}"][$exportport]["{#NAMEPORT}"][$_.Port]["{#NAMEVLUN}"] = @{}
                }
                $3parexport["{#VIRTHOST}"][$exportport]["{#NAMEPORT}"][$_.Port]["{#NAMEVLUN}"][$_.VVName] = @{
                    "KB_CUR" = $_.KB_Cur
                    "SVT_CUR" = $_.Svt_Cur
                    "IO_CUR" = $_."I/O_Cur"
                }
            }        
        }
    }

$3parexport | ConvertTo-Json -Depth 10

#"data": 
#[{"{#VIRTHOST}": "new-node2", "{#NAMEPORT}": "0:1:1", "{#NAMEVLUN}": "15k_fast_system_lun21", "{#IO_CUR}":  "754", "{#KB_CUR}":  "0.73"}
#{"{#VIRTHOST}": "new-node2", "{#NAMEPORT}": "0:1:1", "{#NAMEVLUN}": "7k_snapshot_lun12", "{#IO_CUR}":  "754", "{#KB_CUR}":  "0.73"}]
                                                                   