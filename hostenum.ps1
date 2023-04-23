# Coleta de informações da máquina

# Endereços IP da máquina
$IPs = Get-NetIPAddress -AddressFamily IPv4 | Select-Object IPAddress
Write-Host "Endereços IP da máquina:"
$IPs

# Hostname
$Hostname = (Get-WmiObject -Class Win32_ComputerSystem).Name
Write-Host "Hostname: $Hostname"

# Chaves de registro mais importantes
# Para obter mais chaves de registro, adicione mais caminhos no array abaixo.
$RegistryKeys = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run',
    'HKLM:\SYSTEM\CurrentControlSet\Services'
)

ForEach ($Key in $RegistryKeys) {
    Write-Host "Chave de registro: $Key"
Write-Host "Scheduled Tasks:"
$ScheduledTasks

# Informações de SMB
$SMBInfo = Get-SmbServerConfiguration
Write-Host "Informações de SMB:"
$SMBInfo

# Coletar informações de arquitetura de máquina
$Architecture = (Get-WmiObject -Class Win32_Processor).AddressWidth
Write-Host "Arquitetura da máquina: $Architecture bits"

# Informações de Rota
$RouteInfo = Get-NetRoute -AddressFamily IPv4
Write-Host "Informações de Rota:"
$RouteInfo

# Informações de conexão de porta
$PortInfo = Get-NetTCPConnection
Write-Host "Informações de conexão de porta:"
$PortInfo

# Informações da tabela Arp
$ArpInfo = Get-NetNeighbor
Write-Host "Informações da tabela ARP:"
$ArpInfo

# Informações de configuração de Firewall
$FirewallInfo = Get-NetFirewallProfile
Write-Host "Informações de configuração de Firewall:"
$FirewallInfo

# Antivírus e EDR executando na máquina
$AntivirusInfo = Get-CimInstance -Namespace root\SecurityCenter2 -ClassName AntiVirusProduct
$EDRInfo = Get-WmiObject -Namespace root\cimv2\Security\MicrosoftTPM -Class Win32_ProtectedVolume

Write-Host "Antivírus executando na máquina:"
$AntivirusInfo.displayName

Write-Host "EDR executando na máquina:"
$EDRInfo.ProtectionStatus
