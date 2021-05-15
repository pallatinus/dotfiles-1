# flake.nix - root configuration flake
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

{
  description = "arbitrarily structured system configuration database";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    home-manager.url = "github:nix-community/home-manager";
    modules = {
      url = "path:./modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "path:./utils";
  };

  outputs = { utils, ... }@inputs:
    let
      modules = inputs.modules.nixosModules;
      home-manager-module = inputs.home-manager.nixosModules.home-manager;
    in utils.lib.generateConfiguration inputs {
      uwu = {
        system = "x86_64-linux";
        modules = (with modules.users; [ superwhiskers ])
          ++ (with modules.categories; [
            audio
            fonts
            gnome
            gnupg
            home-manager
            internationalization
            neovim
            network
            nix
            printing
          ]) ++ (with modules.hardware; [ t440p ])
          ++ (with modules.devices; [ uwu ]) ++ [ home-manager-module ];
      };
    };
}
