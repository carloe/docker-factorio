FROM ubuntu

MAINTAINER Liam Raven <https://github.com/LpmRaven>

RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /opt/factorio -s /bin/bash factorio \
  && chown -R factorio.factorio /opt/factorio
USER factorio

ENV HOME /opt/factorio
ENV SAVEFILE /opt/factorio/saves/factorio_save.zip
ENV MAPGENSETTINGS /opt/factorio/map-gen-settings.json
ENV MAPSETTINGS /opt/factorio/map-settings.json 
ENV SERVERSETTINGS /opt/factorio/server-settings.json

WORKDIR /opt/factorio

RUN  wget -q -O - https://factorio.com/get-download/stable/headless/linux64 \
   | grep -o -m1 "/get-download/.*/headless/linux64" \
   | awk '{print "--no-check-certificate https://www.factorio.com"$1" -q -O /tmp/factorio.tar.gz"}' \
   | xargs wget \
     && tar -xzf /tmp/factorio.tar.gz -C /opt \ 
     && rm -rf /tmp/factorio.tar.gz

ADD  map-gen-settings.json /opt/factorio/
ADD  server-settings.json /opt/factorio/
ADD  init.sh /opt/factorio/

EXPOSE 34197/udp
CMD ["./init.sh"]
