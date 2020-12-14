FROM odoo:14.0

# Switch to root user
USER root 

# Instal pip libraries and other tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends nano \
    && pip3 install paramiko \
    && rm -rf /var/lib/apt/lists/*

# Set permissions for /odoo/backups to allow restoring 
RUN mkdir -p /odoo/backups \
    && chown -R odoo /odoo/backups 
VOLUME ["/odoo/backups"]

# Switch back to odoo user
USER odoo 
