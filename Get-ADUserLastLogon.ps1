Import-Module ActiveDirectory

Function Get-ADUserLastLoginn([string]$utilisateur) {
    $dcs  = Get-ADDomainController -Filter {Name -like "*"}
    $time = 0

    Foreach($dc in $dcs) { 
        $hostname  = $dc.HostName
        $listeUser = Get-ADUser $utilisateur | Get-ADObject -Properties lastLogon 
        if($listeUser.LastLogon -gt $time) {
            $time = $listeUser.LastLogon
        }
    }
    $dt = [DateTime]::FromFileTime($time)
    Write-Host $username "derniere connexion le :" $dt 
}

$utilisateur = Read-Host "Entrer le login de l'utilsiateur : "

Get-ADUserLastLogon -UserName $utilisateur