#!/bin/zsh
set -eu
hook_name="$(basename "$0")"
hook_script=".git/hooks/$hook_name"
([ -e "$hook_script" ] && "$hook_script") || true
