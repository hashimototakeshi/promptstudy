#!/bin/bash

# Find all markdown files in the directory
find /home/hashimoto/contents/prompt_engineering/PromptEngineering_lv01_ja -name "*.md" -type f | while read -r file; do
    # Process each file to handle both patterns (with and without blank lines)
    if grep -q -z -P "## .+(\n|\n+\n):::exercise" "$file"; then
        echo "Processing: $file"
        # Create a temporary file for the output
        temp_file="${file}.tmp"
        # Handle cases with one or more newlines between title and :::exercise
        # This will match any title (## 任意のタイトル) followed by :::exercise
        sed -z -E 's/(## .+)(\n+)(:::exercise)/\3\2\1/g' "$file" > "$temp_file"
        # Replace the original file
        mv "$temp_file" "$file"
    fi
done

echo "All files have been processed."
