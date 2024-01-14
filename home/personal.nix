{ pkgs, ... }:

let
  username = "hoanlac";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
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
      "keka"
      "kodi"
      "logi-options-plus"
      "microsoft-edge"
      "messenger"
      "monitorcontrol"
      "onedrive"
      "rectangle"
      "remote-desktop-manager"
      "shottr"
      "slack"
      "surfshark"
      "tailscale"
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
}