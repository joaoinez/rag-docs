#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

input_file="$1"
output_dir="docs"

mkdir -p "$output_dir"

state="directory"
directory_content=""
current_filename=""
file_content=""

while IFS= read -r line; do
  case "$state" in
  "directory")
    if [[ "$line" =~ ^=+$ ]]; then
      echo -n "$directory_content" >"$output_dir/file_tree.txt"
      state="expect_file"
    else
      directory_content+="$line"$'\n'
    fi
    ;;
  "expect_file")
    if [[ "$line" =~ ^File:\ (.*) ]]; then
      # Sanitize filename: remove leading slash, replace path separators with _
      current_filename=$(echo "${BASH_REMATCH[1]}" | sed 's:^/::; s:/:_:g')
      state="expect_separator"
    fi
    ;;
  "expect_separator")
    if [[ "$line" =~ ^=+$ ]]; then
      state="collect_content"
      file_content=""
    fi
    ;;
  "collect_content")
    if [[ "$line" =~ ^=+$ ]]; then
      echo -n "$file_content" >"$output_dir/$current_filename"
      state="expect_file"
    else
      file_content+="$line"$'\n'
    fi
    ;;
  esac
done <"$input_file"

# Handle potential final file
if [[ "$state" == "collect_content" && -n "$file_content" ]]; then
  echo -n "$file_content" >"$output_dir/$current_filename"
fi

rm "$input_file"

echo "Files created in $output_dir:"
ls -1 "$output_dir"
