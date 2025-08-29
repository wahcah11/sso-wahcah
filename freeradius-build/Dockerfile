FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install only what's needed (minimal + no recommends)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        freeradius \
        freeradius-utils \
        curl \
        python3 \
        python3-pip \
        dos2unix \
        ca-certificates \
        iputils-ping \
        netbase && \
    pip3 install --no-cache-dir requests && \
    rm -rf /var/lib/apt/lists/*

# Buat direktori script & copy config
RUN mkdir -p /etc/freeradius/3.0/scripts

COPY freeradius-config/scripts/test_api_exec.py /etc/freeradius/3.0/scripts/test_api_exec.py
COPY freeradius-config/mods-available/exec_test /etc/freeradius/3.0/mods-available/exec_test
COPY freeradius-config/sites-available/default /etc/freeradius/3.0/sites-enabled/default

# Pastikan script bisa dieksekusi
RUN chmod +x /etc/freeradius/3.0/scripts/test_api_exec.py

# Symlink ke mods-enabled
RUN ln -s /etc/freeradius/3.0/mods-available/exec_test /etc/freeradius/3.0/mods-enabled/

# Port FreeRADIUS
EXPOSE 1812/udp 1813/udp

# Jalankan FreeRADIUS dalam mode debug
CMD ["freeradius", "-X"]
