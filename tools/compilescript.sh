#!/bin/bash

# Set the source and destination directories
SOURCE_DIR="./sources/documents"
DESTINATION_DIR="./build-output"

# Color variables
BOLD_MAGENTA='\033[1;35m'
NC='\033[0m'

# Function to display usage information
display_usage() {
    echo "Usage: $0 [options] directory"
    echo -e "${BOLD_MAGENTA}Options:${NC}"
    echo "  -h, --help            Display help message"
    echo ""
    echo "  -a, --all                Starts the compilation script from SOURCE_DIR"
    echo ""
    echo "  -d, --directory   DIR    Starts the compilation script from DIR=Relative path from SOURCE_DIR"
}

declare -g all_directories
declare -g specific_directory

if [[ $# -gt 2 ]]; then
  echo -e "${BOLD_MAGENTA}Error:${NC} too many arguments."
  echo ""
  display_usage
  exit 1
fi

if [[ $# -lt 1 ]]; then
  echo -e "${BOLD_MAGENTA}Error:${NC} too few arguments."
  exit 1
fi

# Parse command line options
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            display_usage
            exit 0
            ;;
        -a|--all)
            all_directories=true
            ;;
        -d|--directory)
            shift
            if [ $# -lt 1 ]; then
              echo -e "${BOLD_MAGENTA}Error:${NC} Specify a directory"
              exit 1
            fi
            specific_directory="$1"
            ;;
        *)
            echo -e "${BOLD_MAGENTA}Error:${NC} Invalid option: $1"
            display_usage
            exit 1
            ;;
    esac
    shift
done

# Function to compile LaTeX files
compile_latex() {
    local dir="$1"
    local filename="$(basename "$dir")"
    local output_dir="$(dirname $DESTINATION_DIR/${dir#$SOURCE_DIR/})"
    local current_dir="$(pwd)"
    echo -e"${BOLD_MAGENTA}Compiling:${NC} ${dir#$SOURCE_DIR/}/$filename ..."

    # Create the corresponding directory structure in the destination folder
    mkdir -p "$output_dir"

    cd "$dir"
    # Compile LaTeX file to PDF
    # Uncomment the end to suppress all the compiler output
    latexmk -lualatex --halt-on-error "$filename.tex" #>/dev/null

    # Move generated PDF file in output_dir
    cd "$current_dir"
    mv "$dir/$filename.pdf" "$output_dir" >/dev/null
}

# Function to traverse directories recursively
traverse_directory() {
  local directory="$1"

  # Loops over directory contents
  for entry in "$directory"/*; do
    if [ -d "$entry" ]; then
      # If entry is a directory, this fucntion is recursively called
      traverse_directory "$entry"
    elif [ -f "$entry" ]; then
      # If entry is a file, check for a tex source of the same name as directory
      dir="${directory##*/}"
      filename="${entry##*/}"

      # When names match, an output is produced
      if [[ "$filename" == "$dir.tex" ]]; then
        compile_latex "$directory"
      fi
    fi
  done
}

# Start traversing the source directory based on the provided argument
if [ -n "$specific_directory" ]; then
    traverse_directory "$SOURCE_DIR/$specific_directory"
    echo "Compilation complete."
elif [ "$all_directories" == true ]; then
    traverse_directory "$SOURCE_DIR"
    echo -e "${BOLD_MAGENTA}Compilation complete.${NC}"
else
    echo -e "${BOLD_MAGENTA}Error:${NC} Please specify a directory to compile or use --all to compile all directories."
    display_usage
    exit 1
fi
