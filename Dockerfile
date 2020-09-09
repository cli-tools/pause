# syntax=docker/dockerfile:1
FROM scratch
ARG TARGETARCH
COPY bin/pause-linux-${TARGETARCH} /pause
USER 65535:65535
ENTRYPOINT ["/pause"]
