FROM odoo:14.0

# Switch to root user
USER root 

# Instal pip libraries and other tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends nano zip unzip wget \
    && python3 -m pip install --upgrade --force-reinstall pip -t /usr/lib/python3/dist-packages \
    && python3 -m pip install --upgrade \
                      paramiko cryptography boto3 botocore pretty_bad_protocol erppeek odooly \
                      -t /usr/lib/python3/dist-packages \
    && rm -rf /var/lib/apt/lists/*

# Cambiar el UID y GID al usuario odoo
RUN usermod -u 1000 odoo
RUN groupmod -g 1000 odoo

# Set permissions for /odoo/backups to allow restoring 
RUN mkdir -p /odoo/backups \
    && chown -R odoo /odoo/backups 
VOLUME ["/odoo/backups"]

# Switch back to odoo user
USER odoo 
