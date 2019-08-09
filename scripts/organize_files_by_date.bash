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
    echo "ERR: '${target_dir}'is not a directory or does not exist!"
  fi

}

move_file_by_date() {
  local target_dir="$1"; shift
  local target_filepath="$1"
  local mod_date=""
  local new_dir=""

  mod_date="$( stat -c %y "${target_filepath}" | cut -d ' ' -f1 )"
  new_dir="${target_dir}"/"${mod_date}"

  sudo mkdir -p "${new_dir}"
  echo "(rsync) | ${new_dir} <<<" $( basename "${target_filepath}" )
  sudo rsync -azh "${target_filepath}" "${new_dir}"
}


organize_files() {
  local target_dir="$1"

  for filepath in "${target_dir}"/*; do

    if [[ -f "${filepath}" ]]; then
      move_file_by_date "${target_dir}" "${filepath}"
    fi
  done
}

main() {
  local target_dirs=( "${TDIR[@]}" )
  local abs_dir=""

  for dir in "${target_dirs[@]}"; do
    abs_dir="$( get_absolute_path "${dir}" )"
    check_path "${abs_dir}"
    organize_files "${abs_dir}"
  done
}

main "${ARGS[@]}"
