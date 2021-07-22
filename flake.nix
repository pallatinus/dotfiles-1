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
    # currently pinned as newer versions break font rendering in chromium
    # https://github.com/NixOS/nixpkgs/issues/131074
    #
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url =
      "github:NixOS/nixpkgs/967d40bec14be87262b21ab901dbace23b7365db";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url =
        "github:nix-community/neovim-nightly-overlay/7ded2a7207bef8d3b55126a76de285907efbaad8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    modules = {
      url = "path:./modules";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        neovim-nightly-overlay.follows = "neovim-nightly-overlay";
        utils.follows = "utils";
      };
    };
    utils.url = "path:./utils";
  };

  outputs = { utils, ... }@inputs:
    let
      modules = inputs.modules.nixosModules;
      home-manager-module = inputs.home-manager.nixosModules.home-manager;
    in utils.lib.createFlake inputs {
      uwu = {
        system = "x86_64-linux";
        modules = builtins.attrValues {
          inherit (modules.categories)
            audio fonts gnome gnupg home-manager internationalization neovim
            network nix printing boot shell fish nixpkgs;
          inherit (modules.hardware) t440p;
          inherit (modules.devices) uwu;
        } ++ [
          (modules.users.superwhiskers.fromUserModules (builtins.attrValues {
            inherit (modules.users.superwhiskers.modules)
              directories graphical shell multimedia packages neovim gnome nyxt
              headless;
          }))
        ] ++ [ home-manager-module ];
      };
      owo = {
        system = "aarch64-linux";
        modules = builtins.attrValues {
          inherit (modules.categories)
            gnupg home-manager internationalization network neovim nix shell
            nixpkgs openssh;
          inherit (modules.hardware) pi3;
          inherit (modules.devices) owo;
        } ++ [
          (modules.users.superwhiskers.fromUserModules (builtins.attrValues {
            inherit (modules.users.superwhiskers.modules)
              directories shell neovim headless;
          }))
        ] ++ [ home-manager-module ];
      };
    };
}
