FROM n8nio/n8n:latest

USER root

# Verify what package manager exists, then install
RUN echo "Checking system..." && \
    cat /etc/os-release && \
    which apk || which apt-get || echo "NO PACKAGE MANAGER FOUND"

RUN apk add --no-cache ffmpeg python3 py3-pip openssh-server || \
    (apt-get update && apt-get install -y ffmpeg python3 python3-pip openssh-server)

RUN pip3 install --break-system-packages edge-tts || pip3 install edge-tts

RUN mkdir -p /var/run/sshd
RUN echo 'node:collapseiq2026' | chpasswd
RUN ssh-keygen -A

EXPOSE 22
USER root
ENTRYPOINT ["/bin/sh", "-c", "/usr/sbin/sshd & exec su node -c 'n8n start'"]
