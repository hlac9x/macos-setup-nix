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
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      home.packages = with pkgs; [
        _1password-gui
        bartender
        iterm2
        keka
        kitty
        monitorcontrol
        onedrive
        rectangle
        slack
        tailscale
      ];
    };
  };
}
