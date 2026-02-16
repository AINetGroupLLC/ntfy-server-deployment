#!/bin/bash

# Start ntfy in the background
/usr/bin/ntfy serve &

# Give ntfy a few seconds to start up
sleep 5

# Send a test notification using curl
echo "Attempting to send test notification from within Docker build..."
curl -v -u "ainetgroupllc:aa136479" \
     -H "Title: Docker Build Test Notification" \
     -d "Ntfy server started successfully during Docker build!" \
     https://ntfy-server-gemini-cli.onrender.com/wise-cloud-falcon-jump

# Keep the ntfy process running (it's already in background, but ensure the script exits cleanly)
wait
