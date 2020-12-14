FROM odoo:14.0

# Switch to root user
USER root 

# Instal pip libraries and other tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends nano \
    && pip3 install paramiko \
    && rm -rf /var/lib/apt/lists/*

# Set permissions and Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /odoo/backups /mnt/free_themes \
    && chown -R odoo /odoo/backups /mnt/free_themes
VOLUME ["/odoo/backups", "/home/odoo/free_themes"]

# Switch back to odoo user
USER odoo 
