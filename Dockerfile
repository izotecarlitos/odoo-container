FROM odoo:14.0

# Switch to root user
USER root 

# Instal pip libraries and other tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                        nano \
                        zip \
                        unzip \
                        wget \
                        gcc \
                        python3-dev \
                        build-essential \
                        libssl-dev \
                        libffi-dev \
                        cargo \
    && python3 -m pip install \
                        wheel \
                        erppeek \
                        odooly \
                        paramiko \
                        cryptography \
                        boto3 \
                        botocore \
                        -t /usr/lib/python3/dist-packages \
    && python3 -m pip install pretty_bad_protocol -t /usr/lib/python3/dist-packages \
    && rm -rf /var/lib/apt/lists/*

# Cambiar el UID y GID al usuario odoo
RUN usermod -u 1000 odoo
RUN groupmod -g 1000 odoo

# Set permissions for /odoo/backups to allow restoring 
RUN mkdir -p /odoo/backups \
    && chown -R odoo:odoo /odoo/backups \
    && mkdir -p /mnt/free-themes \
    && chown -R odoo:odoo /mnt/free-themes \
    && chown -R odoo:odoo /etc/odoo \
    && chmod -R 0640 /etc/odoo \
    && chown -R odoo:odoo /mnt/extra-addons \ 
    && chown -R odoo:odoo /var/log/odoo \
    && chmod -R 0750 /var/log/odoo \
    && chown odoo:odoo /var/lib/odoo 
VOLUME ["/odoo/backups", "/mnt/free-themes"]

# Switch back to odoo user
USER odoo 
