#!/bin/bash

RUN_SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
MAIN_SCRIPT_DIR="${RUN_SCRIPT_DIR}/src/q"
PAUSE_ON_END="true";

# Move user into directory of the q files
cd "${MAIN_SCRIPT_DIR}"

# Starting main.q
q "main.q"

# Return user to previous directory they were in
cd "$OLDPWD"

if [ "$PAUSE_ON_END" = "true" ]; then
    read -p "Press Enter to continue . . . " ans
fi
