FROM binwiederhier/ntfy:latest
COPY server.yml /etc/ntfy/server.yml
COPY acl.yml /etc/ntfy/acl.yml

# Make /etc/ntfy writable during build to allow ntfy to create user.db
RUN chmod 777 /etc/ntfy

# Create users and set ACLs during build time
RUN /usr/bin/ntfy user add ainetgroupllc --role=admin --password "aa136479" --config /etc/ntfy/server.yml
RUN /usr/bin/ntfy user add gemini_cli_agent --password "aa136479" --config /etc/ntfy/server.yml
RUN /usr/bin/ntfy access gemini_cli_agent wise-cloud-falcon-jump write --config /etc/ntfy/server.yml

# Set the command to run ntfy serve
CMD ["ntfy", "serve"]