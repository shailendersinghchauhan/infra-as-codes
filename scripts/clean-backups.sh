#!/usr/bin/env bash
#######################
# Name: clean-backup.sh
# Purpose: Recurses through the sub directories from current dir and remove any *.backup files
# Last updated on 30/11/2020
# Author: Shailender Singh
#######################
find . -depth -type f -name '*.backup' -exec rm -rf '{}' \;
