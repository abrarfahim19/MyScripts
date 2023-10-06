#!/bin/bash

# Specify the source directory containing SVG files
src_directory="/Users/bayshorecommunication/Downloads/qrcode_svg"


# Specify the destination directory for AI files
ai_directory="/Users/bayshorecommunication/Downloads/AI"

# Number of SVG files to process
number_of_files=5

# Change to the source directory
cd "$src_directory"

# Set a counter to keep track of processed files
count=0

# Loop through each SVG file
for svg_file in *.svg; do
    if [ -f "$svg_file" ]; then
        # Construct the expected AI file name
        ai_file="$ai_directory/${svg_file%.svg}.ai"
        echo "Working for $ai_file"

        # Check if the AI file already exists in the destination directory
        if [ -f "$ai_file" ]; then
            echo "AI file $ai_file already exists. Skipping processing of $svg_file."
        else
            # Open SVG file in CorelDraw
            echo "Opening $ai_file with CorelDraw"
            open -a "CorelDraw" "$src_directory/$svg_file"

            # Wait for CorelDraw to open and load the file (adjust sleep time as needed)
            sleep 60

            # Change to the destination directory
            cd "$ai_directory"

            echo "Running automator with CorelDraw"
            # Run the CorelSaveAsAI.workflow Automator workflow
            automator CorelSaveAsAI.workflow

            echo "Automator Success"
            # Wait for the workflow to complete (adjust sleep time as needed)
            sleep 15

            # Find the saved AI file in the destination directory with a wildcard for "Untitled"
            ai_file=$(find "$ai_directory" -type f -name "Untitled*.ai" -print -quit)

            if [ -n "$ai_file" ]; then
                # Rename the saved AI file to match the original SVG file name
                mv "$ai_file" "$ai_directory/${svg_file%.svg}.ai"

                # Increment the counter
                ((count++))

                # Check if we've processed the specified number of files
                if [ $count -eq "$number_of_files" ]; then
                    break
                fi
            else
                echo "Error: AI file not found."
            fi

            # Change back to the source directory for the next iteration
            cd "$src_directory"
        fi

        # Check if we've processed the specified number of files
        if [ $count -eq "$number_of_files" ]; then
            break
        fi
    fi
done
