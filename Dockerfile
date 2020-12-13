FROM odoo:14.0

# Switch to root user
USER root 

# Instal pip libraries and other tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends nano \
    && pip3 install paramiko \
    && rm -rf /var/lib/apt/lists/*

# Set 1000 for the odoo user 
RUN usermod -u 1000 odoo \
    && groupmod -g 1000 odoo 

# Add volumes for backups and free_themes
VOLUME ["/odoo/backups", "/home/odoo/free_themes", "/var/lib/odoo"]

# Switch back to odoo user
USER odoo 
