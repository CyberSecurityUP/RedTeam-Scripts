# Nome da Tarefa Agendada
$taskName = "taskname"

# Caminho completo para o arquivo .exe que você deseja executar como um serviço
$binPath = "C:\Arquivo.exe"

$eventName = "MeuEventoPersonalizado"

# ID do evento para disparar a tarefa
$eventID = 12345

# Verifica se a Tarefa Agendada já existe
$existingTask = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

if ($existingTask -eq $null) {
    # Cria uma nova Tarefa Agendada
    $action = New-ScheduledTaskAction -Execute $binPath
    $triggerLogon = New-ScheduledTaskTrigger -AtLogOn
    $triggerEvent = New-ScheduledTaskTrigger -OnEvent `
        -EventID $eventID `
        -LogName 'Windows PowerShell' `
        -Source 'PowerShell' `
        -XPath "*[System[Provider[@Name='PowerShell'] and (EventID=$eventID)]]"
    $principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet

    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger @($triggerLogon, $triggerEvent) -Principal $principal -Settings $settings

    Write-Host "Tarefa Agendada '$taskName' criada com sucesso." -ForegroundColor Green
} else {
    Write-Host "A Tarefa Agendada '$taskName' já existe." -ForegroundColor Red
}
