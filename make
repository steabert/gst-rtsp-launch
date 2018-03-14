#!/bin/bash
libtool --mode=link \
 gcc `pkg-config --cflags --libs gstreamer-1.0` \
 -L/usr/lib/x86_64-linux-gnu -lgstrtspserver-1.0 \
 -o bin/gst-rtsp-launch src/gst-rtsp-launch.c
