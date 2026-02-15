#!/bin/bash

# Start ntfy server in the background
/usr/bin/ntfy serve &

# Wait for ntfy server to be ready (adjust sleep time if necessary)
echo "Waiting for ntfy server to start..."
sleep 10

# Add users via ntfy CLI
echo "Adding ntfy users..."
# Add ainetgroupllc as admin
ntfy user add ainetgroupllc --role=admin --password "aa136479"
# Add gemini_cli_agent as user
ntfy user add gemini_cli_agent --password "aa136479"

# Grant access for gemini_cli_agent
echo "Granting access for gemini_cli_agent..."
ntfy access gemini_cli_agent wise-cloud-falcon-jump write

echo "ntfy server setup complete. Keeping server running."

# Keep the main process alive (important for Docker)
wait $!
