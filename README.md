# `qgis-kasmvnc`

Run QGIS inside a container and interact with it through the browser.

This repo is a variation of the [`docker-calibre`](https://github.com/linuxserver/docker-calibre) that adapts it to QGIS. The underlying VNC technology is provided through the [`kasmvnc`](https://github.com/linuxserver/docker-baseimage-kasmvnc) image, courtesy of LinuxServer.

## Usage

- Enter into this repo:

> cd /path/to/this/repo

- Run `docker-compose`:

> docker compose up

## Building

- Enter into this repo:

> cd /path/to/this/repo

- Build image:

> docker build -t qgis .


