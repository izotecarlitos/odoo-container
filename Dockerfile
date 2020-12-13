FROM odoo:14.0

# Instal pip libraries and other tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends nano \
    && pip3 install paramiko \
    && rm -rf /var/lib/apt/lists/*
