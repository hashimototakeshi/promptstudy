#!/bin/bash

# Find all markdown files in the directory
find /home/hashimoto/contents/prompt_engineering/PromptEngineering_lv01_ja -name "*.md" -type f | while read -r file; do
    # Check if the file needs to be modified
    if grep -q -E '^###?\s*Hint' "$file" || grep -q -E '^###?\s*ヒント' "$file"; then
        echo "Updating hints in: $file"
        
        # Create a temporary file for the output
        temp_file="${file}.tmp"
        
        # Process the file to update hint sections
        # Handle both "Hint" and "ヒント" cases
        sed -E 's/^(###?\s*)Hint/:::Hint\n\1ヒント/g' "$file" | \
        sed -E 's/^(###?\s*)ヒント/:::Hint\n\1ヒント/g' | \
        # Add closing ::: after the hint section
        sed -E '/^:::Hint/,/^[^:]/ {
            /^[^:]/ {
                x
                /^$/ !{x; b}
                x
            }
            /^[^:]/ !{H; d}
            /^[^:]/ {x; s/\n/\n:::/; p; d}
        }' > "$temp_file"
        
        # Replace the original file if changes were made
        if ! cmp -s "$file" "$temp_file"; then
            mv "$temp_file" "$file"
        else
            rm "$temp_file"
        fi
    fi
done

echo "All files have been processed."
