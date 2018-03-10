#!/bin/bash
docker build -f Dockerfile-buildenv -t buildenv .
docker run --rm -v $PWD:/tmp buildenv /bin/make-buildenv
docker build -f Dockerfile -t gst-rtsp-launch .
