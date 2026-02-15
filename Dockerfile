FROM binwiederhier/ntfy:latest
COPY server.yml /etc/ntfy/server.yml
COPY user.db /etc/ntfy/user.db
COPY acl.yml /etc/ntfy/acl.yml
CMD ["serve"]
