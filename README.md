# Introduction
This repository was forked from [carloe/docker-factorio](https://hub.docker.com/r/carloe/docker-factorio/) to build a custom configured server and provide extra information on how to setup a server using docker.

# Server Setup

AWS offers t2.micro instances that have a free period

# Connect to your server

Windows users will need to look at alterations for using PuTTY.

1. Make note of the IP address of your server (ipv4)  
2. Open terminal
3. `ssh -i /path/my-key-pair.pem ec2-user@my-instance-public-dns-name`, replace 'my-instance-public-dns-name' with the IP address and the pem path to your cert.

# Build Your Server

The latest Factorio headless server is downloaded at build time.

1. `sudo yum install git`
2. `git clone https://github.com/LpmRaven/factorio-docker-server.git`
2. `cd factorio-docker-server`
3. Config your server (see section below then return here)
4. `docker build -t factorio-instance-name .`

# Server Configuration

1. use vi to edit files. eg. `vi server-settings.json`
2. Edit the map-gen-settings.json file, map-settings.json file and the server-settings.json file (DO NOT RENAME THE FILES)
3. Continue to read the previous section

# Persisting Saves

Use a docker volume to persist the savegames on the host machine rather than in the docker container.

```bash
mkdir $(pwd)/saves

# Make sure the saves dir can be written to by the "factorio" user in Docker, with uid 1000
sudo chown 1000:1000 $(pwd)/saves
# (alternatively, if you don't have root): chmod 777 $(pwd)/saves

```

# Load a Save/Map

To load a save, place the save file in the saves folder and name the file: factorio_save.zip
Remove all other files from the save folder as it will load the most recently updated file.

# Basic Usage

The init script will automatically create a new save game if none exists.

Then launch your container as usual.

```bash
docker run -d \
           -v $(pwd)/saves:/opt/factorio/saves \
           -p 34197:34197/udp \
           --restart=always \
           --name factorio-server \
           factorio-instance-name
```

# Play the game!

1. Open Factorio
2. Connect to your server `IPaddress:34197`, change IP address obviously.
3. Default password is `donationswelcome`, feel free to change it.
4. Play the game!

Enjoy. Hope this guide helped you setup your factorio server!
