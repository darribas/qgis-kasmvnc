# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG QGIS_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Dani Arribas-Bel"

ENV \
  CUSTOM_PORT="8080" \
  CUSTOM_HTTPS_PORT="8181" \
  HOME="/config" \
  TITLE="QGIS" \
  QTWEBENGINE_DISABLE_SANDBOX="1"

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://qgis.org/en/_downloads/fec0bc7494ac1248c2aa2d46a9ee7687/qgis-icon128.png && \
  echo "**** install runtime packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    gnupg \
    software-properties-common \
    wget && \
  echo "**** install QGIS ****" && \
  wget -qO - https://qgis.org/downloads/qgis-2020.gpg.key | \
    sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg \
    --import && \
  chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg && \
  apt update && \
  apt install -y qgis qgis-plugin-grass && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY root/ /
