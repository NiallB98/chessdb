#!/bin/bash

# This script takes the port of the server as an argument, though a default is specified if one isn't passed

DEFAULT_PORT=25565
RUN_SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
MAIN_SCRIPT_DIR="${RUN_SCRIPT_DIR}/src/q"

# Move user into directory of the q files
cd "${MAIN_SCRIPT_DIR}"

# Setting port
if [ -z "$1" ]; then
    PORT=$DEFAULT_PORT
else
    PORT=$1
fi

# Starting server on port
q server.q -p "$PORT" || echo -e "\nCould not host server on port $PORT"

# Return user to previous directory they were in
cd "$OLDPWD"
