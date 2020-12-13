FROM odoo:14.0

# Switch to root
USER root 

# Instal pip libraries and other tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends nano \
    && pip3 install paramiko \
    && rm -rf /var/lib/apt/lists/*

# Set permissions and Mount /home/odoo/backups for auto_backup backups
RUN mkdir -p /home/odoo/backups \
    && chown -R odoo /home/odoo/backups
VOLUME ["/home/odoo/backups"]

# Switch to odoo
USER odoo 
