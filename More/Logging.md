

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
