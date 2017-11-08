![docker build](https://img.shields.io/docker/build/carloe/docker-factorio.svg "Docker Builds")
![docker pulls](https://img.shields.io/docker/pulls/carloe/docker-factorio.svg "Docker Pulls")

# Introduction

Dockerfile to build a [Factorio](https://www.factorio.com) game server image. You can find the pre-built images on Docker Hub at [carloe/docker-factorio](https://hub.docker.com/r/carloe/docker-factorio/)

# Basic Usage

The init script will automatically create a new save game if none exists. 

```bash
docker run -d \
           -p 34197:34197/udp \
           --name factorio-server \
           carloe/docker-factorio 
```

# Persisting Saves

Use a docker volume to persist the savegames on the host machine rather than in the docker container.

```bash
mkdir $(pwd)/saves

# Make sure the saves dir can be written to by the "factorio" user in Docker, with uid 1000
sudo chown 1000:1000 $(pwd)/saves
# (alternatively, if you don't have root): chmod 777 $(pwd)/saves

docker run -d \
           -v $(pwd)/saves:/opt/factorio/saves \
           -p 34197:34197/udp \
           --restart=always \
           --name factorio-server \
           carloe/docker-factorio 
```

# Build Your Own

The latest Factorio headless server is downloaded at build time. This may be a good reason you want to build your own image since the Docker Hub repo may not always be up to date.

```bash
git clone https://github.com/carloe/docker-factorio.git
docker build -t some-factorio .
```

Then launch your container as usual.

```bash
docker run -d \
           -v $(pwd)/saves:/opt/factorio/saves \
           -p 34197:34197/udp \
           --restart=always \
           --name factorio-server \
           some-factorio 
```
