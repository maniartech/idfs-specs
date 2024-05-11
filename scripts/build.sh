#!/bin/bash

# Load variables from .env file
if [ -f .env ]; then
    source .env
else
    echo ".env file not found"
    exit 1
fi

current_dir=$(pwd) # current working directory
misc_dir="$current_dir/$MISC_DIR/"
build_dir="$current_dir/$BUILD_DIR/"
modules_dir="$current_dir/$MODULES_DIR/"

temp_markdown="$build_dir/temp_combined.md"
metadata="$misc_dir/metadata.md"

# Loop through the modules directory and add each module to the array
modules=()
for module in $(ls $modules_dir); do
  modules+=($module)
done

# If the build directory does not exist, create it
if [ ! -d "$build_dir" ]; then
  mkdir $build_dir
fi

prepare_master_file() {
  # clear the temp file
  truncate -s 0 $temp_markdown

  # Add metadata to the beginning of the file. Read from metadata.md
  if [ -f "$metadata" ]; then
    cat $metadata >> $temp_markdown
  fi

  # Loop through each module in the defined order
  for module in "${modules[@]}"; do

    module_dir="$modules_dir$module"
    echo "module_dir: $module_dir"

    if [ -d "$module_dir" ]; then
      echo "Processing $module"

      # Before processing each module, add a page break
      echo -e "\n<div style='page-break-after: always;'></div>\n" >> $temp_markdown

      # Check for an intro file and append if exists
      intro="$module_dir/0-intro.md"
      if [ -f "$intro" ]; then
        sed '/./,$!d' "$intro" | sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' >> $temp_markdown
      fi

      # Append each chapter, sorted numerically
      for chapter in $(ls $module_dir/*.md | sort -V); do
        if [ "$chapter" != "$intro" ]; then
          echo "Adding $chapter"

          echo "" >> $temp_markdown

          # Append the chapter content
          sed '/./,$!d' "$chapter" | sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' >> $temp_markdown
        fi
      done

      # Add a page break after each module
      # echo -e "\n<div style='page-break-after: always;'></div>\n" >> $temp_markdown
    fi
  done
}

generate_doc() {
  # Generate the filenames with full paths
  output_doc="${build_dir}$OUTPUT_FILE_NAME.docx"

  # Generate the Word document with a TOC and metadata
  pandoc -s $temp_markdown -o $output_doc \
    --toc --toc-depth=2 \
    --from=markdown --to=docx \
    --reference-doc=$misc_dir/template.dotx \
    --lua-filter=./filters/add-page-breaks.lua \
    --lua-filter=./filters/adjust-headings.lua \
    --verbose

  echo "Word document generated: $output_doc"
}

convert_to_pdf() {
  ps_script=".\\scripts\\generate-pdf.ps1"
  output_doc="${build_dir}$OUTPUT_FILE_NAME.docx"

  powershell.exe -ExecutionPolicy Bypass -File $ps_script "$output_doc"
}

prepare_master_file
generate_doc
convert_to_pdf

# References:
# https://pandoc.org/demos.html
# https://chat.openai.com/c/b2bbc24d-3a42-4bd5-999b-fffb4c7389e3
