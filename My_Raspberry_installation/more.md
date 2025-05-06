# Forzar que sudo pida la contraseña siempre

Edita el archivo de configuración de sudo: ```sudo visudo```

Busca esta línea ```Defaults        env_reset``` y cámbiala por ```Defaults        timestamp_timeout=0```

Esto le dice a sudo que la contraseña expira inmediatamente, por lo que siempre te pedirá la contraseña para cada comando.

# x