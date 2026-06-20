FROM n8nio/n8n:latest

USER root

# Install FFmpeg, Python, and OpenSSH (Alpine Linux uses apk)
RUN apk add --no-cache \
    ffmpeg \
    python3 \
    py3-pip \
    openssh-server

# Install edge-tts (Alpine requires --break-system-packages flag)
RUN pip3 install --break-system-packages edge-tts

# Setup SSH server for Execute Command node access
RUN mkdir -p /var/run/sshd
RUN echo 'node:collapseiq2026' | chpasswd
RUN ssh-keygen -A

EXPOSE 22

USER root
ENTRYPOINT ["/bin/sh", "-c", "/usr/sbin/sshd & exec su node -c 'n8n start'"]
