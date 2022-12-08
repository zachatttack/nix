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
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.gpg = {
    enable = true;
  };
  gtk = {
      enable = true;
      theme = {
        name = "Materia-dark";
        package = pkgs.materia-theme;
      };
  };
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
  
 # nixpkgs.overlays = [
 #   (import (builtins.fetchTarball {
 #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
	# 	 sha256 = "09b0yc3nw4n3zl3m5lhwc1jxl2j1v439l8ibjffma75pr3w9wqpd";
 #     
 #   }))
 # ];

  home.packages = with pkgs; [
    clang-tools
    cmake
    curl
    exa
    fzf
    gcc
    git-crypt
    gnumake
    gnupg
    go
    neofetch
    neovim
    pandoc
    pinentry_qt
    python38
    rnix-lsp
    sumneko-lua-language-server
    texlive.combined.scheme-full
    unzip
    wget
    zsh-autosuggestions
    emacs28NativeComp
    ripgrep
    global
    dig
  ];

  programs.git = {
     enable = true;
     userName = "Zach Thomas";
     userEmail = "zach.thomas1.zt@gmail.com";
     extraConfig = {
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = false;
        };
        core = {
          editor = "nvim";
        };
     };
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      v = "nvim";
      ll = "ls -l";
      ls = "exa";
      la = "exa -a";
      grep = "grep --color=auto";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      g = "git";
      gs = "git status";
    };
    sessionVariables = {
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux#configuration-variables
      # automatically start tmux
      ZSH_TMUX_AUTOSTART = "true";
      ZSH_TMUX_CONFIG = "$XDG_CONFIG_HOME/tmux/tmux.conf";
    };
    oh-my-zsh = { 
      enable = true;
      plugins = [ "tmux" ]; 
    };
  };

  programs.tmux = {
    enable = true;
    aggressiveResize = false;
    baseIndex = 1;
    shortcut = "a";
    escapeTime = 0;
    extraConfig = ''
        # Mouse works as expected
        set-option -g mouse on

        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
        bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l
        bind-key -T copy-mode-vi 'C-Space' select-pane -t:.+
        bind-key R source-file $/home/zach/.config/tmux/tmux.conf \; display-message "/home/zach/.config/tmux/tmux.conf reloaded"
    '';
  };
  programs.starship = {
          enable = true;
          enableZshIntegration = true;
          # https://starship.rs/config/#prompt
  };

}



