{ pkgs, ... }:

let
  username = "hoanlac";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
    casks = [
      "visual-studio-code"
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
        terragrunt
      ];
    };
  };
}
