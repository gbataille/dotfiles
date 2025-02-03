#!/usr/bin/env bash

set -e
set -x

nix flake update
darwin-rebuild switch --flake .
