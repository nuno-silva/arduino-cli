# arduino-cli

[![Docker Pulls](https://img.shields.io/docker/pulls/nuno351/arduino-cli.svg?maxAge=604800)][nuno351/arduino-cli]

[Ubuntu](https://hub.docker.com/_/ubuntu)-based image containing:

* [arduino-cli](https://arduino.github.io/arduino-cli/)
* the [Arduino Core for AVR](https://github.com/arduino/ArduinoCore-avr)
* the [Arduino Core for ESP32](https://github.com/espressif/arduino-esp32)
* the [Arduino Core for ESP8266](https://github.com/esp8266/Arduino)
* git, make, etc

Image is published as [nuno351/arduino-cli].

[![nuno351/arduino-cli](https://dockeri.co/image/nuno351/arduino-cli)](https://hub.docker.com/r/nuno351/arduino-cli)

## Why

You can use this image to:

- build Arduino sketches
- compile code to run on [AVR microcontrollers](https://en.wikipedia.org/wiki/AVR_microcontrollers)
- ...

## Building the image

```bash
nice bash build.sh
```

[nuno351/arduino-cli]: https://hub.docker.com/r/nuno351/arduino-cli/
