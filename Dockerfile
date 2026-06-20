# v3 rebuild trigger
FROM n8nio/n8n:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    python3 \
    python3-pip \
    python3-venv \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN python3 --version && pip3 --version

RUN pip3 install --break-system-packages edge-tts

RUN mkdir -p /var/run/sshd
RUN echo 'node:collapseiq2026' | chpasswd
RUN ssh-keygen -A

EXPOSE 22

USER root
ENTRYPOINT ["/bin/sh", "-c", "/usr/sbin/sshd & exec su node -c 'n8n start'"]
