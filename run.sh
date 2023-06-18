#!/bin/bash

RUN_SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
MAIN_SCRIPT_DIR="${RUN_SCRIPT_DIR}/src/q"
CURRENT_DIR="$(pwd)"

# Move user into directory of the q files
cd "${MAIN_SCRIPT_DIR}"

# Run main.q script
q "main.q"

# Return user to previous directory they were in
cd "${CURRENT_DIR}"

read -p "Press Enter to continue" ans
