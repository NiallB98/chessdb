#!/bin/bash

RUN_SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
MAIN_SCRIPT_DIR="${RUN_SCRIPT_DIR}/src/q"
PAUSE="true"
DEBUG="true"
DEBUG_CLEAR_ON_RESTART="true"
IGNORE_SERVER="false"
SERVER_PROC_ID=""

# Server handling
startserver () {
    if [ -z "$SERVER_PROC_ID" ]; then
        q "server.q" & >/dev/null
        SERVER_PROC_ID="$!"
        echo "Background server process started"
    else
        echo "Background server process already running"
    fi
}

killserver () {
    if [ ! -z "$SERVER_PROC_ID" ]; then
        if ps -p "$SERVER_PROC_ID" > /dev/null; then
            isup="true"
        else
            isup="false"
        fi

        if [ "$isup" = "true" ]; then
            has_errored="false"
            kill -9 "$SERVER_PROC_ID" || has_errored="true"

            if [ "$has_errored" = "true" ]; then
                echo "Could not end server process with ID: $SERVER_PROC_ID"
            else
                echo "Ended background server process"
            fi

        elif [ "$DEBUG" = "true" ]; then
            echo "No background server process found"
        fi

    elif [ "$DEBUG" = "true" ]; then
            echo "No background server process was started, nothing to end"
    fi

    SERVER_PROC_ID=""
}

# Move user into directory of the q files
cd "${MAIN_SCRIPT_DIR}"

actions () {
    #startserver
    q "main.q"
    #killserver

    if [ "$PAUSE" = "true" ]  && [ "$DEBUG" = "false" ]; then
        read -p "Press Enter to continue . . . " ans
    elif [ "$DEBUG" = "true" ]; then
        read -p "Would you like to restart the server process and main.q? [Y/N] " ans
        if [ ! "${ans^^}" = "Y" ]; then
            DEBUG="false"
        fi
    fi
}

actions
while [ "$DEBUG" = "true" ]; do
    if [ "$DEBUG" = "true" ] && [ "$DEBUG_CLEAR_ON_RESTART" = "true" ]; then
        clear
    fi

    actions
done

# Return user to previous directory they were in
cd "$OLDPWD"
