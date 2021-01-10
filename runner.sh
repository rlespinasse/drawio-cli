#!/usr/bin/env bash
set -e

# Remove Election 9 deprecation warnings from error output
suppress_deprecation_warnings() {
  while read -r line; do
    echo "$line" | grep -v "allowRendererProcessReuse is deprecated\|is deprecated due to security and usability issues\|is deprecated and will be removed\|is deprecated and will be changing\|DeprecationWarning: Passing functions"
  done
}

# Remove auto-update message from standard output
# Waiting for https://github.com/jgraph/drawio-desktop/issues/166
suppress_autoupdate_warnings() {
  while read -r line; do
    echo "$line" | grep -v "Checking for update\|Generated new staging user ID\|Found version\|@update-available@"
  done
}

# shellcheck disable=SC2068
if [ "${DRAWIO_CLI_SUPPRESS_WARNINGS:-false}" = true ]; then
  "$DRAWIO_CLI" $@ --no-sandbox 2> >(suppress_deprecation_warnings) | suppress_autoupdate_warnings
else
  # Currently drawio-desktop can hang inside a docker container
  # https://github.com/jgraph/drawio-desktop/issues/127
  echo "WARNING: This process can hang sometimes, don't hesitate to kill it."
  "$DRAWIO_CLI" $@ --no-sandbox
fi
