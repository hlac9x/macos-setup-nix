{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep curl
  environment.systemPackages = with pkgs; [
    # Languages & Lib
    aria
    gnupg
    go
    pyenv
    python313
    virtualenv

    # DevOps tools
    colima
    git
    k9s
    kubectl
    kubectl-tree
    kubectx
    kubelogin
    kubent
    kubernetes-helm
    kustomize
    neovim
    packer
    terraform
    terragrunt
    tfswitch

    # AWS & Azure
    aws-iam-authenticator
    awscli2
    eksctl
    ssm-session-manager-plugin

    # Utilities
    bat
    curl
    direnv
    fd
    fzf
    gh
    inetutils
    jq
    ripgrep
    tree
  ];

  environment.systemPath = [
    config.homebrew.brewPrefix # TODO https://github.com/LnL7/nix-darwin/issues/596
  ];

  fonts = {
    fontDir.enable = true;
    fonts = [
      pkgs.meslo-lgs-nf
    ];
  };

  # Homebrew packages
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      { name = "kreuzwerker/taps"; }
    ];
    brews = [
      "azure-cli"
      "pyyaml"
      "docker"
      "docker-buildx"
      "docker-completion"
      "docker-credential-helper"
    ];
    casks = [
      "alacritty"
      "visual-studio-code"
    ];
  };

  time.timeZone = "Asia/Bangkok";
  
  system.defaults = {
    alf = {
      globalstate = 1;
    };
    finder = {
      ShowStatusBar = true;
      ShowPathbar = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      AppleEnableSwipeNavigateWithScrolls = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      "com.apple.swipescrolldirection" = true;
    };
    CustomUserPreferences = {
      "com.apple.Safari" = {
        AlwaysRestoreSessionAtLaunch = true;
        AutoOpenSafeDownloads = false;
        EnableNarrowTabs = false;
        IncludeDevelopMenu = true;
        NeverUseBackgroundColorInToolbar = true;
        ShowFullURLInSmartSearchField = true;
        ShowOverlayStatusBar = true;
        ShowStandaloneTabBar = false;
      };
    };
  };

  services = {

  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Nix setting
  nix = {
    # configureBuildUsers = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      allowed-users = [
        "@admin"
      ];
    };
  };

  # Nix packages config
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = true;
    promptInit = "";
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Network setting
  networking.knownNetworkServices = [ "Wi-Fi" "Ethernet" ];
  networking.dns = [ "8.8.8.8" "8.8.4.4" ];

}