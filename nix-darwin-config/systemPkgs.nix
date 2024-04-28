{ pkgs ? import <nixpkgs> {} }:

with pkgs;
[
  awscli2
  bat
  btop
  curl
  direnv
  eza
  fzf
  git
  grc
  httpie
  jq
  maven
  neovim
  openssh
  opentofu
  pyenv
  ripgrep
  tig
  vim
  wget
  yadm
  zellij
]
