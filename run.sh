#!/bin/bash

RUN_SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
MAIN_SCRIPT_DIR="${RUN_SCRIPT_DIR}/src/q"
CURRENT_DIR="$(pwd)"
DEBUG=true

# Move user into directory of the q files
cd "${MAIN_SCRIPT_DIR}"

actions () {
    q "main.q"

    if [ "$DEBUG" == "true" ]; then
        read -p "\nDo you want to re-run main.q? [Y/N] " ans
        
        if [ "${ans^^}" != "Y" ]; then
            DEBUG=false
        fi
    fi
}

actions
while [ "$DEBUG" == "true" ]; do
   actions
done

# Return user to previous directory they were in
cd "${CURRENT_DIR}"

read -p "Press Enter to continue" ans
