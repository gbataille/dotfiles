{ pkgs ? import <nixpkgs> {} }:

with pkgs;
[
  _1password-cli
  awscli2
  bat
  btop
  curl
  direnv
  difftastic
  docker-compose
  eza
  fzf
  git
  grc
  httpie
  ipcalc
  jjui
  jujutsu
  jq
  libpq
  maven
  neovim
  openssh
  ripgrep
  tenv
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
