#!/bin/bash

# Get all tags from /usr/include
find /usr/include -type f -exec ctags -a '{}' \;
