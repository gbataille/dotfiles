{ pkgs ? import <nixpkgs> {} }:

with pkgs;
[
  curl
  eza
  vim
  wget

  btop
  awscli
  bat
  direnv
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
  zellij
  yadm
]
