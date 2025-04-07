# Obtener el nombre del dispositivo a desinstalar
$deviceName = "Plantronics Blackwire 3225 Series"

# Obtener la lista de dispositivos instalados
$devices = Get-PnpDevice | Where-Object { $_.FriendlyName -like "*$deviceName*" }

# Desinstalar el driver
foreach ($device in $devices) {
    try {
        $instanceId = $device.InstanceId
        Start-Process "pnputil" -ArgumentList "/remove-device $instanceId /force" -Wait
        Write-Host "Driver $($device.FriendlyName) desinstalado correctamente."
    } catch {
        Write-Host "Error al desinstalar el driver $($device.FriendlyName): $_"
    }
}

if (-not $devices) {
    Write-Host "No se encontró ningún dispositivo con el nombre '$deviceName'."
}