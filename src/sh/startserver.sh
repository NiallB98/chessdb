#!/bin/bash

startserver () {
    q "server.q" & >/dev/null
    SERVER_PROC_ID="$!"
    echo "$SERVER_PROC_ID"
}

startserver
