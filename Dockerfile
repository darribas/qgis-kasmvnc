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
  wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg \
	https://download.qgis.org/downloads/qgis-archive-keyring.gpg && \
  echo "Types: deb deb-src" > /etc/apt/sources.list.d/qgis.sources && \
  echo "URIs: https://qgis.org/ubuntu" >> /etc/apt/sources.list.d/qgis.sources && \
  echo "Suites: jammy" >> /etc/apt/sources.list.d/qgis.sources && \
  echo "Architectures: amd64" >> /etc/apt/sources.list.d/qgis.sources && \
  echo "Components: main" >> /etc/apt/sources.list.d/qgis.sources && \
  echo "Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg" >> /etc/apt/sources.list.d/qgis.sources && \
  echo "**** cleanup ****" && \
  apt update && \
  apt install -y \
	python3-pip \
	python3-qgis \
	python3-qgis-common \
	python3-venv \
     	python3-pytest \
	python3-mock \
	qgis \
	qgis-plugin-grass \
	qttools5-dev-tools \
	xvfb && \
  apt clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY root/ /
