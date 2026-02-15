FROM binwiederhier/ntfy:latest
COPY server.yml /etc/ntfy/server.yml
COPY user.db /etc/ntfy/user.db
COPY acl.yml /etc/ntfy/acl.yml
COPY entrypoint.sh /entrypoint.sh # Changed path
RUN chmod +x /entrypoint.sh       # Changed path
RUN ls -l /                       # Debugging
RUN ls -l /usr/local/bin/         # Debugging
ENTRYPOINT ["/entrypoint.sh"]     # Changed path
CMD ["serve"] # This CMD will be ignored because ENTRYPOINT is set, but good practice