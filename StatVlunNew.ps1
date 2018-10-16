$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass.2.1" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataVlun = Get-3parStatVlun -SANConnection $Connection1 -Iteration 1
$removessh = ($Connection1 | Remove-SSHSession)
$3parexport = @{}
$dataVlun | ForEach-Object {
    $exportport = ($_.Host)+($_.Port)+($_.VVName)
    If (-Not $3parexport.ContainsKey($exportport)) {
        $3parexport[$exportport] = @{
            "KBCur" = $_.KB_Cur
            "SVTCur" = $_.Svt_Cur
            "IOCur" = $_."I/O_Cur"
            "RWCur" = $_."r/w_Cur"
        }
    
            }        
        }
    

$3parexport | ConvertTo-Json -Depth 10