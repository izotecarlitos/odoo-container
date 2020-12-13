FROM odoo:14.0

# Switch to root user
USER root 

# Instal pip libraries and other tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends nano \
    && pip3 install paramiko \
    && rm -rf /var/lib/apt/lists/*

# Set permissions and Mount /home/odoo/backups for auto_backup backups
RUN usermod -u 1000 odoo \
    && groupmod -g 1000 odoo #\
    #&& mkdir -p /odoo/backups /home/odoo/free_themes \
    #&& chown -R odoo /odoo/backups /home/odoo/free_themes /mnt/extra-addons
#VOLUME ["/odoo/backups", "/home/odoo/free_themes"]

# Switch to odoo user
USER odoo 
