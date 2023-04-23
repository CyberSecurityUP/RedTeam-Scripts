# Substitua o caminho abaixo pelo caminho do arquivo .exe desejado
$CustomExePath = "C:\arquivo.exe"

# Verifica se o arquivo .exe existe
if (Test-Path $CustomExePath) {
    # Define o caminho do registro que contém a configuração do Userinit
    $RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

    # Obtém o valor atual do Userinit
    $Current_Userinit = Get-ItemProperty -Path $RegistryPath -Name Userinit | Select-Object -ExpandProperty Userinit

    # Adiciona o caminho do arquivo .exe ao valor do Userinit, separado por uma vírgula
    $New_Userinit = $Current_Userinit.TrimEnd(',') + ',' + $CustomExePath

    # Define o novo valor do registro Userinit
    Set-ItemProperty -Path $RegistryPath -Name Userinit -Value $New_Userinit

    Write-Host "O valor do registro Userinit foi atualizado para incluir: $CustomExePath"
} else {
    Write-Host "O arquivo .exe não foi encontrado no caminho especificado: $CustomExePath"
}
