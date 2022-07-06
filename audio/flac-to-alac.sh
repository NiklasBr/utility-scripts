#!/usr/bin/env bash

# Usage: 
# /path/to/script.sh /path/to/flac/dir/
# /mnt/c/Users/Niklas/Documents/scripts/flac-to-alac.sh flac/

set -e # exit immediately on error
set -u # error if a variable is misspelled

while read -r my_file; do
  # ./foo/bar.flac => ./foo/bar.m4a
  my_new="$(dirname "$my_file")/$(basename "$my_file" .flac).m4a"

  ffmpeg -nostdin -i "$my_file" -c:v copy -c:a alac "$my_new"

  # safe because of set -e, but still do a test run
  #rm "$my_file"
done <<< "$(find . -type f -name '*.flac')"

