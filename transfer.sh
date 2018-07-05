#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
RAW_SITE_PATH="$(cd $SCRIPT_DIR/../phil-harmoniq.github.io; pwd)"

if [[ ! -s "$RAW_SITE_PATH/.git" ]]; then
    echo "Error: Unable to locate phil-harmoniq.github.io site repository at $RAW_SITE_PATH/.git"
    exit 1
fi

echo "Transferring static site files"
echo "$SCRIPT_DIR/_site  ->  $RAW_SITE_PATH"

cp -r "$SCRIPT_DIR/_site/" "$RAW_SITE_PATH/"
