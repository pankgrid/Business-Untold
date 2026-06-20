FROM alpine:3.20 AS tools

RUN apk add --no-cache ffmpeg python3 py3-pip

RUN pip3 install --break-system-packages --target=/python-packages edge-tts


FROM n8nio/n8n:latest

USER root

COPY --from=tools /usr/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=tools /usr/bin/ffprobe /usr/local/bin/ffprobe
COPY --from=tools /usr/lib /usr/lib
COPY --from=tools /usr/bin/python3 /usr/local/bin/python3
COPY --from=tools /usr/lib/python3.12 /usr/lib/python3.12
COPY --from=tools /python-packages /usr/lib/python3.12/site-packages

ENV PATH="/usr/local/bin:${PATH}"
ENV PYTHONPATH="/usr/lib/python3.12/site-packages"

USER node
