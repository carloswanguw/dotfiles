#!/bin/bash

readonly SCRIPTNAME=$( basename "$0" )
readonly SCRIPTDIR="$(cd "$(dirname "$0")" && pwd)"
readonly ARGS="$@"

readonly TDIR=("$@")

get_absolute_path() {
  target_dir="$1"

  echo "$( readlink -f "${target_dir}" )"
}

check_path() {
  target_dir="$1"
    
  if ! [[ -d "${target_dir}" ]]; then
    echo "ERR: Directory doesn't exist!"
    exit
  fi
}

get_subfilepaths() {
  local target_dir="$1"
  local -n subfilepaths_tmp="$2"
  local oldIFS="${IFS}"

  IFS=$'\n'
  subfilepaths_tmp=( $( find "${target_dir}" -type f ) )
  IFS="${oldIFS}"
}

move_file_by_date() {
  local target_filepath="$1"
  local target_dirpath="$( dirname "${target_filepath}" )"
  local target_dirname="$( basename "${target_dirpath}" )"
  local mod_date=""
  local new_dir=""

  mod_date="$( stat -c %y "${target_filepath}" | cut -d ' ' -f1 )"

  # If file is not already in a subfolder matching its date, create a date
  # folder and move the file to it.
  if [[ "${target_dirname}" != "${mod_date}" ]]; then
    new_dir="${target_dirpath}"/"${mod_date}"
    sudo mkdir -p "${new_dir}"
    echo "(   move   ) | ${new_dir} <<<" $( basename "${target_filepath}" )
    sudo mv "${target_filepath}" "${new_dir}"
  else
    echo "(do nothing)" "|" "${target_filepath}"
  fi
}


organize_files() {
  local filepaths=( "$@" )
  local target_dir=""

  for filepath in "${filepaths[@]}"; do

    if [[ -f "${filepath}" ]]; then
      move_file_by_date "${filepath}"
    else
      echo "${filepath}"
    fi
  done
}

main() {
  local target_dirs=( "${TDIR[@]}" )
  local abs_dir=""
  local subfilepaths=()

  for dir in "${target_dirs[@]}"; do
    abs_dir="$( get_absolute_path "${dir}" )"

    if [[ -d "${abs_dir}" ]]; then
      get_subfilepaths "${abs_dir}" subfilepaths
      organize_files "${subfilepaths[@]}"
    fi
  done
}

main "${ARGS[@]}"
