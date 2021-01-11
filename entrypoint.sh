#!/usr/bin/env bash
set -e

# Start Xvfb
Xvfb -ac -screen scrn 1280x2000x24 :9.0 2>/dev/null &
export DISPLAY=:9.0

# Start runner and enable signals to it
trap 'kill -TERM $PID' TERM INT
# shellcheck disable=SC2068
/drawio/runner.sh "$@" &
PID=$!
wait $PID
trap - TERM INT
wait $PID
exit $?
