#!/bin/bash

current_dir=$(pwd) # current working directory
build_dir="$current_dir/build/"
modules_dir="$current_dir/modules/"
temp_markdown="$build_dir/temp_combined.md"
metadata="metadata.md"
modules=("lims" "accounts" "membership")  # Define the order of modules explicitly

prepare_master_file() {
  # clear the temp file
  echo "" > $temp_markdown


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

      # Optional: Add a title for each module as a new chapter or section
      # echo -e "# $module\n" >> $temp_markdown

      # Check for an intro file and append if exists
      intro="$module_dir/0-intro.md"
      if [ -f "$intro" ]; then
        cat "$intro" >> $temp_markdown
      fi

      # Append each chapter, sorted numerically
      for chapter in $(ls $module_dir/*.md | sort -V); do
        if [ "$chapter" != "$intro" ]; then
          echo "Adding $chapter"
          # Append a blank line before each chapter
          echo -e "\n" >> $temp_markdown

          # Append the chapter content
          cat "$chapter" >> $temp_markdown
        fi
      done

      # Add a page break after each module
      echo -e "\n\\newpage\n" >> $temp_markdown
    fi
  done
}


generate_doc() {
  # Generate the filenames with full paths
  output_doc="${build_dir}chemo-doc-$(date +'%Y-%m-%d').docx"

  # Generate the Word document with a TOC and metadata
  pandoc -s $temp_markdown -o $output_doc \
    --toc --toc-depth=2 \
    --from=markdown --to=docx \
    --reference-doc=./template.dotx \
    --lua-filter=./filters/add-page-breaks.lua \
    --lua-filter=./filters/add-cover-page.lua \
    --lua-filter=./filters/adjust-headings.lua \
    --verbose

  echo "Word document generated: $output_doc"
}

convert_to_pdf() {
  ps_script=".\\generate-pdf.ps1"
  doc="chemo-doc-$(date +'%Y-%m-%d').docx"
  doc_path=".\\build\\$doc"

  powershell.exe -ExecutionPolicy Bypass -File $ps_script "$doc_path"
}

prepare_master_file
generate_doc
convert_to_pdf

# References:
# https://pandoc.org/demos.html
# https://chat.openai.com/c/b2bbc24d-3a42-4bd5-999b-fffb4c7389e3
