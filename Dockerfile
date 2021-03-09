FROM odoo:14.0

# Switch to root user
USER root 

# Install pip libraries and other tools
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

# Change UID/GID for odoo user/group
RUN usermod -u 1000 odoo
RUN groupmod -g 1000 odoo

# Create folders and set permissions for odoo user/group after assigning UID/GID 
RUN mkdir -p /mnt/backups \
             /mnt/filestore \
             /mnt/free-themes \
    && chown -R odoo:odoo \
             /etc/odoo \
             /mnt/extra-addons \
             /mnt/backups \
             /mnt/filestore \
             /mnt/free-themes \
             /var/lib/odoo \
             /var/log/odoo \
    && chmod -R 0640 /etc/odoo \
    && chmod -R 0750 /var/log/odoo 
    
# Publish volumes
VOLUME ["/mnt/backups", "/mnt/filestore", "/mnt/free-themes"]

# Switch back to odoo user
USER odoo 
