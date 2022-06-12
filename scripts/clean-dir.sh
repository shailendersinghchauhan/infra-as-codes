#!/usr/bin/env bash
# Recurses through the sub directories from current dir and remove any .terraform1
find . -depth -type d -name '.terraform1' -exec rm -rf '{}' \;
