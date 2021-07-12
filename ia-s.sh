#!/bin/sh
has() {
  case "$(command -v $1 2>/dev/null)" in
    alias*|"") return 1
  esac
}
has ia && {
  exec ia "$@"; :
} || { 
  [ -e ./ia ] && { ./ia "$@";:;} || {
    { has curl && has python; } && {
      curl -LO --progress-bar https://archive.org/download/ia-pex/ia
      chmod +x ./ia
      exec ./ia "$@"; :
    } || { printf '%s\n' '
  ia (internetarchive) was not found
    - nor was curl/python
  ia can be installed from the internetarchive package
    - if it is present in your PM
  otherwise:
    - please download ia from https://archive.org/download/ia-pex/ia
    - mark it is executable
    - add it to $PATH
  '; exit 1; }
  }
}
