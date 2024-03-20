{ pkgs, ... }:

let
  username = "hlac";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
    masApps = {
      # Need to be signed into the Mac App Store
      "Telegram" = 747648890;
    };
    casks = [
      "1password-cli"
      "1password"
      "bartender"
      "evkey"
      "istat-menus"
      "keka"
      "microsoft-edge"
      "messenger"
      "monitorcontrol"
      "notion"
      "orbstack"
      "rectangle"
      "remote-desktop-manager"
      "shottr"
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
