{ pkgs ? import <nixpkgs> {} }:

with pkgs;
[
  awscli2
  bat
  btop
  curl
  direnv
  difftastic
  eza
  fzf
  git
  grc
  httpie
  ipcalc
  jjui
  jujutsu
  jq
  maven
  neovim
  openssh
  opentofu
  ripgrep
  tig
  typst
  uv
  vim
  wget
  yadm
  yq
  zellij
  # zig
]
