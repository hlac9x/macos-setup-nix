{ pkgs, ... }:

let
  username = "hoanlac";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/home/${username}";

  homebrew = {
    # casks = [
    #   "diffusionbee"
    #   "firefox"
    # ];
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
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
      # home.file.".config/alacritty/alacritty.yml".text = builtins.readFile ../files/alacritty.yml;
      # home.file.".config/karabiner/karabiner.json".text = builtins.readFile ../files/karabiner.json;
      # home.file.".config/kitty/kitty.d/macos.conf".text = builtins.readFile ../files/kitty.conf;
      home.packages = with pkgs; [
        azure-cli
      ];
    };
  };
}
