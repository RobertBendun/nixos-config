{ config, pkgs, ... }:

{
  xdg = {
    enable = true;
    userDirs = {
      enable    = true;
      desktop   = "$HOME/desktop";
      documents = "$HOME/docs";
      download  = "$HOME/downloads";
    };
  };

  home.sessionVariables = rec {
    BROWSER = "firefox";
    EDITOR = "nvim";
    VISUAL = EDITOR;
  };

  # Programs that require configuration
  imports = [ ./progs/alacritty.nix ];

  programs = {
    rofi = {
      enable = true;
      terminal = "${pkgs.alacritty}/bin/alacritty";
    };

    neovim = {
      enable = true;
      vimAlias = true;
      extraConfig = builtins.readFile ./config.vim;
      plugins = with pkgs.vimPlugins; [
        gruvbox
        vim-nix
        coc-nvim
        haskell-vim
      ];
    };

    git = {
      enable = true;
      userName = "Robert Bendun";
      userEmail = "robert@bendun.cc";
      extraConfig = {
        github.user = "RobertBendun";
        pull.rebase = true;
        color.ui = true;
        hub.protocol = "ssh";
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      shellAliases = import ./aliases.nix;
      autocd = true;
      initExtra = builtins.readFile ./init.zsh;
    };
  };

  # Programs without additional configuration
  home.packages = with pkgs; [
    bear
    ccls
    dmenu
    firefox
    fmt
    gcc
    ghc
    gnumake
    haskell-language-server
    haskellPackages.xmobar
    haskellPackages.xmonad
    home-manager
    mypy
    nodejs
    python.pkgs.pip
    python.pkgs.pylint
    python38
    xorg.libX11
  ];

  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
        hp.xmonad-contrib
      ];
      config = ./config.hs;
    };
  };
}
