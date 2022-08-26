{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "zach";
  home.homeDirectory = "/home/zach";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
  
 nixpkgs.overlays = [
   (import (builtins.fetchTarball {
     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
		 sha256 = "100nh32vlyw48zl0m4y258pdsb0bmjlqlarahk5svv6g25plpzrv";
   }))
 ];

  home.packages = with pkgs; [
    alacritty
    stow
    git
    zsh
    curl
    ansible
    git-crypt
    gnupg
    wget
    firefox
    neovim
    gcc
    gnumake
    cmake
    unzip
    discord
    python38
    neofetch
    pinentry_qt
    rnix-lsp
    go
    usbutils
    texlive.combined.scheme-medium
    sumneko-lua-language-server
    okular
    clang-tools
    pandoc
    tmux
    runelite
    steam
    steam-run-native
    adoptopenjdk-icedtea-web
    exa
    fzf
    yarn
    obsidian
    nfs-utils
  ];
}
