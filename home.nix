{ config, pkgs, ... }:

{
  xdg.enable = true;
  
  home.sessionVariables = rec { 
    BROWSER = "firefox";
    EDITOR = "nvim"; 
    VISUAL = EDITOR;
  };

  # Programs that require configuration
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
        vim-nix
        gruvbox
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
    };
  };

  # Programs without additional configuration
  home.packages = with pkgs; [
    alacritty
    dmenu
    firefox
    home-manager
    gnumake
    gcc

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
