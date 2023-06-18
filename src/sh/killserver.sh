SERVER_ID="$1"

killserver () {
    kill -9 "$SERVER_ID" >/dev/null || has_errored="true"

    if [ "$has_errored" = "true" ]; then
        echo "0b"
    else
        echo "1b"
    fi
}

killserver
