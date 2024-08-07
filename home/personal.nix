{ pkgs, ... }:

let
  username = "hoanlac";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
    brews = [
      "docker-buildx"
      "docker-completion"
      "docker-compose"
      "docker-credential-helper"
      "docker"
    ];
    masApps = {
      # Need to be signed into the Mac App Store
      "Telegram" = 747648890;
      "Microsoft To Do" = 1274495053;
      "Microsoft Outlook" = 985367838;
    };
    casks = [
      "1password"
      "adguard"
      "anydesk"
      "bartender"
      "evkey"
      "istat-menus"
      "lens"
      "keka"
      "kodi"
      "logi-options-plus"
      "messenger"
      "microsoft-edge"
      "microsoft-teams"
      "monitorcontrol"
      "notion"
      "onedrive"
      "orbstack"
      "rectangle"
      "remote-desktop-manager"
      "shottr"
      "slack"
      "surfshark"
      "vlc"
      "whatsapp"
      "zalo"
      "zoom"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, lib, ... }: {
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      home.file.".config/alacritty/alacritty.toml".text = builtins.readFile ../files/alacritty.toml;
      home.packages = with pkgs; [

      ];
    };
  };

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.25;
      minimize-to-application = true;
      mru-spaces = false;
      showhidden = true;
      tilesize = 50;
        # `1`: Disabled
        # `2`: Mission Control
        # `3`: Application Windows
        # `4`: Desktop
        # `5`: Start Screen Saver
        # `6`: Disable Screen Saver
        # `7`: Dashboard
        # `10`: Put Display to Sleep
        # `11`: Launchpad
        # `12`: Notification Center
        # `13`: Lock Screen
        # `14`: Quick Note
      wvous-tl-corner = 1;
      wvous-bl-corner = 1;
      wvous-tr-corner = 4;
      wvous-br-corner = 14;
    };
  };
}
