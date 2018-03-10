FROM debian:stretch

RUN apt-get update && apt-get install --no-install-recommends -y \
    libgstrtspserver-1.0-0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
 && rm -rf /var/lib/apt/lists/*

ADD bin/gst-rtsp-launch /usr/bin/gst-rtsp-launch

EXPOSE 8554

ENTRYPOINT ["/usr/bin/gst-rtsp-launch"]
CMD ["videotestsrc ! x264enc ! rtph264pay name=pay0 pt=96"]
