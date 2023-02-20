#!/bin/bash
# Ignoring every folder starting with "."
find . -type d -not -path "./.*" | xargs -I '{}' ./webp.sh '{}' 