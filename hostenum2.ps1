# Coleta de informações da máquina

# Endereços IP da máquina
$IPs = Get-NetIPAddress -AddressFamily IPv4 | Select-Object IPAddress
Write-Host "Endereços IP da máquina:"
$IPs | Format-Table -AutoSize

# Hostname
$Hostname = hostname
Write-Host "Hostname: $Hostname"

# Chaves de registro mais importantes
$RegistryKeys = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run',
    'HKLM:\SYSTEM\CurrentControlSet\Services'
)

ForEach ($Key in $RegistryKeys) {
    Write-Host "Chave de registro: $Key"
    (Get-Item -Path $Key).Property
}

# Arquivos de senha em .txt
$PasswordFiles = Get-ChildItem -Path C:\ -Include *.txt -Recurse -ErrorAction SilentlyContinue | Select-String -Pattern "senha"
Write-Host "Arquivos de senha em .txt:"
$PasswordFiles | Format-Table -AutoSize

# Scheduled Tasks
$ScheduledTasks = Get-ScheduledTask
Write-Host "Scheduled Tasks:"
$ScheduledTasks | Format-Table -AutoSize

# Informações de SMB
$SMBInfo = Get-SmbServerConfiguration
Write-Host "Informações de SMB:"
$SMBInfo | Format-List

# Coletar informações de arquitetura de máquina
$Architecture = (Get-WmiObject -Class Win32_Processor).AddressWidth
Write-Host "Arquitetura da máquina: $Architecture bits"

# Informações de Rota
$RouteInfo = Get-NetRoute -AddressFamily IPv4
Write-Host "Informações de Rota:"
$RouteInfo | Format-Table -AutoSize

# Informações de conexão de porta
$PortInfo = Get-NetTCPConnection
Write-Host "Informações de conexão de porta:"
$PortInfo | Format-Table -AutoSize

# Informações da tabela Arp
$ArpInfo = Get-NetNeighbor
Write-Host "Informações da tabela ARP:"
$ArpInfo | Format-Table -AutoSize

# Informações de configuração de Firewall
$FirewallInfo = Get-NetFirewallProfile
Write-Host "Informações de configuração de Firewall:"
$FirewallInfo | Format-List

# Antivírus e EDR executando na máquina
$AntivirusInfo = Get-CimInstance -Namespace root\SecurityCenter2 -ClassName AntiVirusProduct

Write-Host "Antivírus executando na máquina:"
$AntivirusInfo.displayName

# EDR executando na máquina
# Não há um método universal para identificar todos os EDRs. Então, neste exemplo, verificamos se o Windows Defender está executando.
$WindowsDefenderStatus = Get-MpComputerStatus
Write-Host "Windows Defender executando na máquina:"
$WindowsDefenderStatus.AntispywareEnabled
