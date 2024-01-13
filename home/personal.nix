{ pkgs, ... }:

let
  username = "hoanlac";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
    casks = [
      "anydesk"
      "evkey"
      "istat-menus"
      "kodi"
      "lens"
      "logi-options-plus"
      "microsoft-edge"
      "onedrive"
      "remote-desktop-manager"
      "shottr"
      "surfshark"
      "telegram-desktop"
      "vlc"
      "whatsapp"
      "zalo"
      "zoom"
    ];
    masApps = {
      # Need to be signed into the Mac App Store
      # "Bitwarden" = 1352778147;
      # Azure VPN Client
    };
  };

  # TODO clean up
  system.activationScripts.extraUserActivation.text = ''
    sudo pmset -a lowpowermode 1
  '';

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, lib, ... }: {
      home.stateVersion = "23.05";
      programs.home-manager.enable = true;
      home.packages = with pkgs; [
        pkgs._1password-gui
        pkgs.bartender
        pkgs.iterm2
        pkgs.keka
        pkgs.kitty
        pkgs.monitorcontrol
        pkgs.rectangle
        pkgs.slack
        pkgs.tailscale
      ];
    };
  };
}
