![Logo](https://github.com/FIN392/Raspberry/raw/main/images/motionEye-Logo.png)

# CCTV with motionEye

The goal is to ... I'm working on it.

Please, send me your comments, critics, doubts, requests or sues.

## Requirements

1. aaa ...
2. bbb ...
3. ccc ...

## Steps

1. ...[Installation of '*motionEye*'](#motionEye)
2. ...[bbb](#bbb)
3. ...[ccc](#ccc)

## <a name="motionEye"></a>Installation of '*motionEye*'

aaa ...


```
sudo -i

apt-get install ffmpeg v4l-utils


```

## <a name="bbb"></a>bbb

bbb ...

## <a name="ccc"></a>ccc

ccc ...

---


### Enable and test de camera

*(From SSH console)*

Option A:

```
    sudo raspi-config

    - Select option '3 Interface Options'
 
    - Select '<Select>'

    - Select 'P1 Camera'

    - Select '<Select>'

    - 'Would you like the camera interface to be enabled?'
    - Select '<Yes>'

    - 'The camera interface is enabled'
    - Select '<Ok>'

    - Select '<Finish>'

    - 'Would you like to reboot now?'
    - Select '<Yes>'
```

Option B:

```
    sudo raspi-config nonint do_camera 1
    sudo reboot
```

raspistill --verbose --output test.jpg

# 3280x2464
raspistill --output /home/pi/Pictures/test.jpg

# 640x480
raspistill --output /home/pi/Pictures/test-small.jpg --width 640 --height 480

# video
raspivid --output /home/pi/Pictures/test-video.h264

# No pink
raspistill --verbose --settings --shutter $2 --vflip --hflip --ev -24 --ISO 100 --awb off --awbgains 1.0,1.0 --drc high --stats --nopreview --quality 10 --timeout 100 --output /home/pi/Pictures/test-nopink.jpg

~

https://eltallerdelbit.com/motioneye-raspberry-pi/
