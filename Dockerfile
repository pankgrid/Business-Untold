FROM n8nio/n8n:latest

USER root

# Install FFmpeg and Python for Edge TTS
RUN apk add --no-cache ffmpeg python3 py3-pip

# Install edge-tts
RUN pip3 install edge-tts --break-system-packages

USER node
