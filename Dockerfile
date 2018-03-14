FROM debian:stretch AS build

RUN apt-get update && apt-get install --no-install-recommends -y \
    gcc pkg-config libtool-bin \
    libgstrtspserver-1.0-dev \
 && rm -rf /var/lib/apt/lists/*

COPY src/gst-rtsp-launch.c gst-rtsp-launch.c
RUN libtool --mode=link \
 gcc `pkg-config --cflags --libs gstreamer-1.0` \
 -L/usr/lib/x86_64-linux-gnu -lgstrtspserver-1.0 \
 -o gst-rtsp-launch gst-rtsp-launch.c

FROM debian:stretch
RUN apt-get update && apt-get install --no-install-recommends -y \
    libgstrtspserver-1.0-0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build gst-rtsp-launch /usr/bin/gst-rtsp-launch

EXPOSE 8554

ENTRYPOINT ["/usr/bin/gst-rtsp-launch"]
CMD ["videotestsrc ! x264enc ! rtph264pay name=pay0 pt=96"]
