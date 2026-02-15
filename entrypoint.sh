#!/bin/bash

# Ensure ntfy server is not already running from a previous attempt
killall ntfy || true

# Generate password hashes
CEO_HASH=$(/usr/bin/ntfy user hash "aa136479")
AGENT_HASH=$(/usr/bin/ntfy user hash "aa136479")

# Create user.db and populate with users and ACLs using sqlite3
# This ensures persistence and correct loading by the ntfy server
echo "Populating user.db with users and ACLs..."
sqlite3 user.db <<EOF
CREATE TABLE IF NOT EXISTS users (id TEXT PRIMARY KEY, hash TEXT NOT NULL, role TEXT NOT NULL, created INTEGER NOT NULL, last_login INTEGER);
CREATE TABLE IF NOT EXISTS access (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT NOT NULL, topic TEXT NOT NULL, access TEXT NOT NULL);

-- Add ainetgroupllc as admin
INSERT OR REPLACE INTO users (id, hash, role, created, last_login) VALUES ('ainetgroupllc', '$CEO_HASH', 'admin', strftime('%s', 'now'), strftime('%s', 'now'));

-- Add gemini_cli_agent as user
INSERT OR REPLACE INTO users (id, hash, role, created, last_login) VALUES ('gemini_cli_agent', '$AGENT_HASH', 'user', strftime('%s', 'now'), strftime('%s', 'now'));

-- Grant gemini_cli_agent write access to wise-cloud-falcon-jump
INSERT OR REPLACE INTO access (user_id, topic, access) VALUES ('gemini_cli_agent', 'wise-cloud-falcon-jump', 'write');
EOF

# Start ntfy server
echo "Starting ntfy server..."
/usr/bin/ntfy serve