FROM n8nio/n8n:latest

USER root

# Detect package manager and install dependencies
RUN if command -v apt-get >/dev/null 2>&1; then \
        apt-get update && apt-get install -y --no-install-recommends \
        ffmpeg python3 python3-pip openssh-server \
        && rm -rf /var/lib/apt/lists/*; \
    elif command -v apk >/dev/null 2>&1; then \
        apk add --no-cache ffmpeg python3 py3-pip openssh; \
    fi

# Install edge-tts
RUN pip3 install edge-tts --break-system-packages 2>/dev/null || pip3 install edge-tts

# Setup SSH for node user
RUN mkdir -p /var/run/sshd
RUN echo 'node:collapseiq2026' | chpasswd
RUN ssh-keygen -A

EXPOSE 22

USER root
ENTRYPOINT ["/bin/sh", "-c", "(/usr/sbin/sshd || /usr/sbin/sshd.distrib) & exec su node -c 'n8n start'"]
