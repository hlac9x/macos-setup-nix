{ pkgs, ... }:

let
  username = "hoanlac";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
    casks = [
      "brave-browser"
      "royal-tsx"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, lib, ... }: {
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      # home.file.".config/alacritty/alacritty.yml".text = builtins.readFile ../files/alacritty.yml;
      # home.file.".config/karabiner/karabiner.json".text = builtins.readFile ../files/karabiner.json;
      # home.file.".config/kitty/kitty.d/macos.conf".text = builtins.readFile ../files/kitty.conf;
      home.packages = with pkgs; [
        _1password-gui
        bartender
        iterm2
        keka
        kitty
        monitorcontrol
        rectangle
        slack
        tailscale
      ];
    };
  };
}