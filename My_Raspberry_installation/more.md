

Dispositivo Raspberry Pi = RASPBERRY PI 2
Sistema operativo = RASPBERRY PI OS LITE (32-BIT)

![image](https://github.com/user-attachments/assets/3e962b85-f41f-4be7-8d49-f5d99adc4083)

Terminal SSH

![image](https://github.com/user-attachments/assets/69b1e323-acc4-4c2e-bc08-0135f7e479cf)






# Forzar que sudo pida la contraseña siempre

Edita el archivo de configuración de sudo: ```sudo visudo```

Busca esta línea ```Defaults        env_reset``` y cámbiala por ```Defaults        timestamp_timeout=0```

Esto le dice a sudo que la contraseña expira inmediatamente, por lo que siempre te pedirá la contraseña para cada comando.

# lastLogLines.sh
```journalctl --identifier="telegramMonitoring" --reverse --lines=20```

# poc_logtest.sh
```
logMessage="Done"
logPriority="info"

logger -t "telegramMonitoring" -p user.$logPriority "[$(basename $0)] $logMessage"

logMessage="Opps!"
logPriority="warn"

logger -t "telegramMonitoring" -p user.$logPriority "[$(basename $0)] $logMessage"


logMessage="ERROR!!!"
logPriority="err"

logger -t "telegramMonitoring" -p user.$logPriority "[$(basename $0)] $logMessage"
```

# poc_tempfile.sh
```
#!/bin/bash

# Crear un archivo temporal
temp_file=$(mktemp)
# Configurar un trap para eliminar el archivo temporal al salir del script
trap 'rm -f "$temp_file"' EXIT







# Usar el archivo temporal
echo "Este es un archivo temporal" > "$temp_file"
cat "$temp_file"

# Simular una finalización satisfactoria
echo "Script ejecutado exitosamente"

# El archivo temporal se eliminará automáticamente al salir del script
```
