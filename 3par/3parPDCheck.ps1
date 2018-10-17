$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataVlun = Get-3parPD | Select-Object -SkipLast 1
$removessh = ($Connection1 | Remove-SSHSession)
$data = @()

$dataVlun | ForEach-Object {

    $3parexport = @{}

    $3parexport["{#DISKID}"] = $_.Id
    $3parexport["{#CAGEPOS}"] = $_.CagePos
    $3parexport["{#TYPE}"] = $_.Type
    $3parexport["{#RPM}"] = $_.RPM
    $3parexport["{#STATE}"] = $_.State
    $3parexport["{#TOTAL}"] = $_.Total
    $3parexport["{#FREE}"] = $_.Free
    $3parexport["{#A}"] = $_.A
    $3parexport["{#B}"] = $_.B
    
    $data += $3parexport

}

$exportdata = @{}
$exportdata["data"] = $data

$exportdata | ConvertTo-Json -Depth 10 -Compress