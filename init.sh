#!/bin/bash

if [ ! -f $SAVEFILE ]; then
  /opt/factorio/bin/x64/factorio --create $SAVEFILE --map-gen-settings $MAPSETTINGS
fi
/opt/factorio/bin/x64/factorio --start-server $SAVEFILE --server-settings $SERVERSETTINGS
