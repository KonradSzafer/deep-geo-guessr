#!/usr/bin/env bash

# convert to raw python script
jupyter nbconvert --to script country_classification_torch.ipynb

# add tabs after script beginning
FILENAME="country_classification_torch.py"

readarray -t file_lines < $FILENAME
truncate -s 0 $FILENAME
add_indent=False
script=()

for line in "${file_lines[@]}"; do
    if [ "$add_indent" == True ]; then
        line="    $line"
        script+=("$line")
    else
        script+=("$line")
    fi
    if [ "$line" == "# !script" ]; then
        # adding indent from now
        script+=("if __name__ == '__main__':")
        add_indent=True
    fi
done

for line in "${script[@]}"; do
    echo "$line" >> "$FILENAME"
done
