$Connection1 = Set-3parPoshSshConnectionUsingPasswordFile -epwdFile "C:\zabbix\3par\keypass" -SANIPAddress 192.168.1.60 -SANUserName zabbixtoolkitps
$dataVlun = Get-3parVVList
$removessh = ($Connection1 | Remove-SSHSession)

$data = @()

$dataVlun | ForEach-Object {

    $3parexport = @{}

    $3parexport["{#ID}"] = $_.Id
    $3parexport["{#PROV}"] = $_.Prov
    $3parexport["{#NAME}"] = $_.Name
    $3parexport["{#TYPE}"] = $_.Type
    $3parexport["{#COPYOF}"] = $_.CopyOf
    $3parexport["{#BSID}"] = $_.BsId
    $3parexport["{#RD}"] = $_.Rd
    $3parexport["{#STATE}"] = $_."-Detailed_State-"
    $3parexport["{#SNP}"] = $_.Snp
    $3parexport["{#USR}"] = $_.Usr
    $3parexport["{#VSIZE}"] = $_.VSize

    
    $data += $3parexport

}

$exportdata = @{}
$exportdata["data"] = $data

$exportdata | ConvertTo-Json -Depth 10 -Compress