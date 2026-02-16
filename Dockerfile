FROM binwiederhier/ntfy:latest

# Explicitly remove old config files to force reliance on environment variables
RUN rm -f /etc/ntfy/server.yml /etc/ntfy/user.db /etc/ntfy/acl.yml

# Copy the entrypoint script and make it executable
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to our script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Set the command for ntfy (will be passed to entrypoint.sh if needed, but not directly executed by Docker)
CMD [""]