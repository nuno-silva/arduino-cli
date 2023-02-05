ARG DATE=latest
FROM alpine
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG DATE

# config for arduino-cli
# https://arduino.github.io/arduino-cli/0.29/configuration/
# need to define these ASAP because installer calls 'arduino-cli version', which creates files in default arbitrary .arduino15 folder
ENV ARDUINO_DIRECTORIES_DATA=/arduino
ENV ARDUINO_DIRECTORIES_DOWNLOADS=/tmp/download
ENV ARDUINO_UPDATER_ENABLE_NOTIFICATION=false

ARG ESP32_BOARDS_URL=https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
ARG ESP8266_BOARDS_URL=https://arduino.esp8266.com/stable/package_esp8266com_index.json
ENV ARDUINO_BOARD_MANAGER_ADDITIONAL_URLS="$ESP32_BOARDS_URL $ESP8266_BOARDS_URL"

# install arduino-cli
RUN apk add curl git make bash py3-pyserial \
	&& curl -sS "https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh" \
	-o install.sh \
	&& BINDIR=/bin sh install.sh \
	&& rm install.sh \
	&& which arduino-cli

# install arduino core for ESP32 and ESP8266
# note that arduino-cli doesn't cleanup after itself and leaves ~700MB of downloaded packages
RUN pwd && echo ${HOME} \
	&& arduino-cli config init \
	&& cat $ARDUINO_DIRECTORIES_DATA/arduino-cli.yaml \
	&& arduino-cli core update-index \
	&& arduino-cli core install esp8266:esp8266 \
	&& arduino-cli core install esp32:esp32 \
	&& du -hs $ARDUINO_DIRECTORIES_DOWNLOADS \
	&& rm -vrf $ARDUINO_DIRECTORIES_DOWNLOADS

ARG VERSION=dev

# add version info
RUN echo "$VERSION" >> /version \
	&& echo "date $DATE" >> /version \
	&& date -u >> /version \
	&& cat /version
