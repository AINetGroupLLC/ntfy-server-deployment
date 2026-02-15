FROM binwiederhier/ntfy:latest
COPY server.yml /etc/ntfy/server.yml
COPY user.db /etc/ntfy/user.db
COPY acl.yml /etc/ntfy/acl.yml

# Initialize user.db before adding users
RUN touch /etc/ntfy/user.db # ADDED: Ensure user.db exists and is writable

# Create users and set ACLs during build time
RUN /usr/bin/ntfy user add ainetgroupllc --role=admin --password "aa136479"
RUN /usr/bin/ntfy user add gemini_cli_agent --password "aa136479"
RUN /usr/bin/ntfy access gemini_cli_agent wise-cloud-falcon-jump write

# Set the command to run ntfy serve
CMD ["ntfy", "serve"]