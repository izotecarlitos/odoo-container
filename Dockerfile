FROM odoo:14.0

# Change to root 
USER root

# Create backup folder and instal pip libraries
RUN mkdir -p /odoo/backups && \
    chown -R odoo /odoo && \
    pip3 install paramiko

# Add the backup folder as a volume
VOLUME ["/odoo/backups"]

# Set back to default user when running the container
USER odoo
