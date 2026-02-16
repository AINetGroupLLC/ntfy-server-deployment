FROM binwiederhier/ntfy:latest

# Explicitly remove old config files to force reliance on environment variables
RUN rm -f /etc/ntfy/server.yml /etc/ntfy/user.db /etc/ntfy/acl.yml

# Set the command to run ntfy serve
CMD ["ntfy", "serve"]
