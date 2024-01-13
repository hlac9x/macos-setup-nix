{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    # more stuff
  };
  
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep curl
  environment.systemPackages = with pkgs; [
    pkgs.argocd
    pkgs.aws-iam-authenticator
    pkgs.awscli2
    pkgs.bat
    pkgs.colima
    pkgs.docker
    pkgs.docker-buildx
    pkgs.docker-credential-helpers
    pkgs.eksctl
    pkgs.fzf-zsh
    pkgs.go
    pkgs.inetutils
    pkgs.jq
    pkgs.k9s
    pkgs.kubectl
    pkgs.kubectl
    pkgs.kubectx
    pkgs.kubelogin
    pkgs.kubent
    pkgs.kubernetes-helm
    pkgs.kustomize
    pkgs.neovim
    pkgs.packer
    pkgs.pyenv
    pkgs.python313
    pkgs.ripgrep
    pkgs.ssm-session-manager-plugin
    pkgs.terraform
    pkgs.terragrunt
    pkgs.tree
    pkgs.virtualenv
    pkgs.vscode
    pkgs.zoxide
    # (pass.withExtensions (ext: with ext; [
    #   pass-otp
    # ]))
  ];

  environment.systemPath = [
    config.homebrew.brewPrefix # TODO https://github.com/LnL7/nix-darwin/issues/596
  ];

  fonts = {
    fontDir.enable = true;
    fonts = [
      pkgs.meslo-lgs-nf
      # (pkgs.nerdfonts.override {
      #   fonts = [
      #     "meslo-lgs-nf"
      #   ];
      # })
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
      "m1-terraform-provider-helper"
      "pyyaml"
    ];
    casks = [
      "session-manager-plugin"
      "visual-studio-code"
    ];
  };

  system.defaults = {
    alf = {
      globalstate = 1;
    };
    dock = {
      autohide = true;
      minimize-to-application = true;
      mru-spaces = false;
      showhidden = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
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
    karabiner-elements.enable = true;
    tailscale.enable = true;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

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

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = false;
    promptInit = "";
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
