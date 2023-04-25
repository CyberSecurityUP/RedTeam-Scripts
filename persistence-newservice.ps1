# Nome do serviço
$serviceName = "MeuNovoServico"

# Caminho completo para o arquivo .exe que você deseja executar como um serviço
$binPath = "C:\Caminho\Para\Seu\Arquivo.exe"

$serviceDescription = "Hacked"

# Verifica se o serviço já existe
$existingService = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if ($existingService -eq $null) {
    # Cria o novo serviço
    New-Service -Name $serviceName -BinaryPathName $binPath -DisplayName $serviceName -Description $serviceDescription -StartupType Automatic

    Start-Service -Name $serviceName

    Write-Host "Serviço '$serviceName' criado e iniciado com sucesso." -ForegroundColor Green
} else {
    Write-Host "O serviço '$serviceName' já existe." -ForegroundColor Red
}
