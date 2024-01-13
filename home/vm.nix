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
      "anydesk"
      "bartender"
      "evkey"
      "istat-menus"
      "keka"
      "kodi"
      "logi-options-plus"
      "microsoft-edge"
      "monitorcontrol"
      "rectangle"
      "remote-desktop-manager"
      "shottr"
      "slack"
      "surfshark"
      "tailscale"
      "telegram-desktop"
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