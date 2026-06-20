FROM n8nio/n8n:latest

USER root

# Install FFmpeg, Python, and SSH server
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    python3 \
    python3-pip \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Install edge-tts
RUN pip3 install edge-tts --break-system-packages

# Setup SSH for node user
RUN mkdir /var/run/sshd
RUN echo 'node:collapseiq2026' | chpasswd
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Create startup script that runs both SSH and n8n
RUN echo '#!/bin/sh\n/usr/sbin/sshd\nexec su node -c "n8n start"' > /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 22

USER root
ENTRYPOINT ["/docker-entrypoint.sh"]
