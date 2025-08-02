![Logo](https://github.com/FIN392/Raspberry/raw/main/Raspberry-Logo.png)

# Proceso de instalación de mi Raspberry Pi
*(Actualizado en mayo de 2025)*

Esto es una guía paso a paso para la instalación de **mi** Raspberry Pi.

Estos son los pasos para mi propio hardware, por lo que podrían ser ligeramente diferentes en tu caso.

## Requerimientos

- Una Raspberry Pi.
- Una tarjeta SD.
- Acceso a Internet.
- Un ordenador Windows con lector de SD y un cliente SSH instalado (por ejemplo el OpenSSH incluido en Windows como una *característica adicional*).

## ¿Que hardware tengo yo?

- [Raspberry Pi 2 Model B Rev 1.1](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)
- [TP-Link USB WiFi Adapter TL-WN725N](https://www.tp-link.com/us/home-networking/usb-adapter/tl-wn725n/)

El adaptador USB Wifi no es necesario, tambien se puede conectar un cable de red de la Raspberry al router de casa.

## Pasos

1. [Grabar la tarjeta SD con el SO de Raspberry Pi](#sd).
2. [Primer inicio](#startup).
3. [Actualización y configuración](#update).
4. [Copia de seguridad](#backup).

## <a name="sd"></a>Grabar la tarjeta SD con el SO de Raspberry Pi

*(En un ordenador Windows)*

Descargar el programa [Raspberry Pi Imager](https://www.raspberrypi.org/software/).

Ejecutar el programa para instalarlo y al final ejecutarlo.

![image](https://github.com/user-attachments/assets/0b838105-b0f3-4ca7-88e8-67f970ec647d)

Pulsar en '*ELEGIR DISPOSITIVO*' y seleccionar '*Raspberry Pi 2 - Model B*'.

Pulsar en '*ELEGIR SO*' y seleccionar '*Raspberry Pi OS (other)*' y luego '*Raspberry Pi OS Lite (32-bit)*'.

Pulsar en '*ELEGIR ALMACENAMIENTO*' y seleccionar la tarjeta SD.

Pulsar en '*SIGUIENTE*'

![image](https://github.com/user-attachments/assets/74c9a23f-77b3-4ad4-a96e-8477d89f9d75)

Pulsar en '*EDITAR AJUSTES*'.

Configurar '*GENERAL*', '*SERVICIOS*' y '*OPCIONES*' de la siguiente forma:

- *Nombre de anfitrión*: Nombre que tendrá tu Raspberry.
- *Nombre de usuario*: Nombre del usuario por defecto. Tradicionalmente era '*pi*' pero es más seguro cambiarlo.
- *Contrasñea*: Contraseña del usuario por defecto. Será usada para elevar permisos '*su*'.
- *SSID*: Nombre de la red Wifi.
- *Contrasñea*: Contraseña de la red Wifi.

![image](https://github.com/user-attachments/assets/37be67b7-15c7-4d96-9a6e-3e5206457a72)
![image](https://github.com/user-attachments/assets/357e038b-c6a9-4c8f-b581-4dd317207d3f)
![image](https://github.com/user-attachments/assets/3a77cfdf-f0e3-439f-97a3-80b63086fe27)

Pulsar en '*GUARDAR*'.

![image](https://github.com/user-attachments/assets/3c3186d8-9870-4b16-abef-a61ca13fe465)

Pular en '*SÍ*'.

![image](https://github.com/user-attachments/assets/e21b6d1a-9513-4e2b-b23c-3d12a3cebbdb)

Pulsar en '*SÍ*'.

Tras unos minutos el proceso de generación de la tarjeta SD termina.

![image](https://github.com/user-attachments/assets/409ea692-c2f3-4ac5-86e1-db9cfb3f11b9)

Pulsar en '*CONTINUAR*' y sacar la tarjeta SD del lector.

## <a name="startup"></a>Primer inicio

*(En la Raspberry Pi)*

Concetar un monitor al puerto HMDI de la Raspberry Pi, insertar la tarjeta SD y encender.

Tras varios minutos y reinicios se mostrará algo similar a esto:

```
Raspbian GNU/Linux 12 FIN392PI tty1
My IP address in 192.168.1.20 fe80:ef73:d389:f130:5526
FIN392PI login: _
```

Anotar la dirección IP y retirar el cable HDMI de la Raspbery Pi. 

A partir de este momento el acceso a la Raspberry Pi se realizará desde un cliente SSH.

*(En un ordenador Windows)*

Desde una ventana de símbolo del sistema (*CMD*) ejecute el cliente SSH con el siguiente comando:

```
C:\> ssh.exe master@192.168.1.20
```

La IP debe ser la mostrada por pantalla en el primer inicio y el usuario (*master*) debe ser el elegido en la creación de la SD.

Si se muestra el siguiente mensaje...

``` 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25159 key sent by the remote host is
SHA256:MFKJ/n8PpDzevg3hmTvr+NFAjE32xn7K4LFW8zXPMTC.
Please contact your system administrator.
Add correct host key in C:\\Users\\fin392/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in C:\\Users\\fin392/.ssh/known_hosts:3
Host key for 192.168.1.20 has changed and you have requested strict checking.
Host key verification failed.
```

Eliminar el siguiente fichero:

```
C:\>del  C:\Users\fin392\.ssh\known_hosts
```

Si se muestra el siguiente mensaje...

```
The authenticity of host '192.168.1.20 (192.168.1.20)' can't be established.
ED25159 key fingerprint is SHA256:MFKJ/n8PpDzevg3hmTvr+NFAjE32xn7K4LFW8zXPMTC.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Contestar con '*yes*'

```master@192.168.1.20's password:```

Teclee la contraseña del usuario por defecto elegida en la creación de la SD.

Si se muestra este mensaje:

```
Linux FIN392PI 6.12.25+rpt-rpi-v7 #1 SMP Raspbian 1:6.12.25-1+rpt1 (2025-04-30) armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
master@FIN392PI:~ $
```

Enhorabuena, ya esta dentro de su Raspberry Pi.

## <a name="update"></a>Actualización y configuración

Ahora necesitara hacer algunas configuraciones, y para ello es más sencillo que lo ejecute todo como '*root*':

```
sudo -i
```

### Forzar a que *sudo* pida siempre la contraseña

Ejecutar ```visudo``` y reemplazar la línea ```Defaults        env_reset``` por ```Defaults        env_reset, timestamp_timeout=0```.

Editar el archivo '/etc/sudoers.d/010_pi-nopasswd' y reemplaza ```master ALL=(ALL) NOPASSWD: ALL``` por ```master ALL=(ALL) ALL```.

### Cambiar la IP dinámica (DHCP) por una IP estática

```
nmcli con mod "preconfigured" ipv4.addresses 192.168.1.10/24
nmcli con mod "preconfigured" ipv4.gateway 192.168.1.1
nmcli con mod "preconfigured" ipv4.dns "1.1.1.1 8.8.8.8"
nmcli con mod "preconfigured" ipv4.method manual
```

```
nmcli con down "preconfigured" && nmcli con up "preconfigured"
```

Tras este paso deberas volver a conectar con tu Raspberry Pi. Esta vez con la nueva IP.

```
C:\> ssh.exe 192.168.1.10 -l master
```

### Actualizar el SO

Primero ...

```
apt update -y
apt upgrade -y
apt autoremove -y
```
... y despues ...

```
sudo reboot
```

## <a name="backup"></a>Copia de seguridad

Es muy recomendable hacer una copia de la tarjeta SD. "Win32 Disk Imager" es una excelente opción para esto, así que visita su sitio web oficial [win32diskimager.org](https://win32diskimager.org/).

---
