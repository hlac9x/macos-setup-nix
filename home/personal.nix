{ pkgs, ... }:

let
  username = "hoanlac";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
    casks = [
      "1password"
      "bartender"
      "evkey"
      "istat-menus"
      "iterm2"
      "keka"
      "kitty"
      "kodi"
      "lens"
      "logi-options-plus"
      "microsoft-edge"
      "monitorcontrol"
      "onedrive"
      "rectangle"
      "remote-desktop-manager"
      "shottr"
      "slack"
      "ssm-session-manager-plugin"
      "surfshark"
      "tailscale"
      "telegram-desktop"
      "upwork"
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
        pkgs.anydesk
        pkgs.upwork       
      ];
    };
  };
}
