FROM binwiederhier/ntfy:latest
COPY server.yml /etc/ntfy/server.yml
COPY user.db /etc/ntfy/user.db
COPY acl.yml /etc/ntfy/acl.yml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN ls -l /usr/local/bin/ # ADDED FOR DEBUGGING
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["serve"] # This CMD will be ignored because ENTRYPOINT is set, but good practice
