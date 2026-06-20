FROM n8nio/n8n:latest

USER root

RUN cat /etc/os-release > /tmp/osinfo.txt && cat /tmp/osinfo.txt
RUN ls /sbin/apk /usr/bin/apt-get 2>&1 || true
RUN which apk 2>&1 || echo "no apk"
RUN which apt-get 2>&1 || echo "no apt-get"

USER node
