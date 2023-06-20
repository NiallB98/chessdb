#!/bin/bash

# This script takes the port of the server as an argument, though a default is specified if one isn't passed

Q_CMD="q"
DEFAULT_PORT=25565
RUN_SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
MAIN_SCRIPT_DIR="${RUN_SCRIPT_DIR}/src/q"
PAUSE_ON_END="true";

# Setting port
if [ -z "$1" ]; then
    PORT=$DEFAULT_PORT
else
    PORT=$1
fi

# Move user into directory of the q files
cd "${MAIN_SCRIPT_DIR}"

echo "Starting server.q . . ."
$Q_CMD server.q -p "$PORT" || echo -e "\nCould not host server on port $PORT"

# Return user to previous directory they were in
cd "$OLDPWD"

if [ "$PAUSE_ON_END" = "true" ]; then
    read -p "Press Enter to continue . . . " ans
fi
