FROM n8nio/n8n:latest

USER root

# Install FFmpeg and Python for Edge TTS (Debian-based image)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install edge-tts
RUN pip3 install edge-tts --break-system-packages

USER node
