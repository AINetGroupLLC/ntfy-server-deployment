FROM binwiederhier/ntfy:latest
WORKDIR /app # Set working directory to /app

COPY server.yml /etc/ntfy/server.yml
COPY user.db /app/user.db # Copy user.db to the writable /app directory
COPY acl.yml /etc/ntfy/acl.yml

# Initialize user.db before adding users (in the writable WORKDIR)
RUN touch ./user.db # Ensure user.db exists and is writable in /app

# Create users and set ACLs during build time
RUN /usr/bin/ntfy user add ainetgroupllc --role=admin --password "aa136479" --config /etc/ntfy/server.yml
RUN /usr/bin/ntfy user add gemini_cli_agent --password "aa136479" --config /etc/ntfy/server.yml
RUN /usr/bin/ntfy access gemini_cli_agent wise-cloud-falcon-jump write --config /etc/ntfy/server.yml

# Set the command to run ntfy serve
CMD ["ntfy", "serve"]
