# default.nix - system configuration of the superwhiskers account
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

{ utils, ... }:
utils.lib.createUser {
  username = "superwhiskers";
  extraUserConfiguration = { pkgs, ... }: {
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  modules = {
    directories = ./directories.nix;
    graphical = ./graphical.nix;
    shell = ./shell.nix;
    multimedia = ./multimedia.nix;
    packages = ./packages.nix;
    neovim = ./neovim.nix;
    gnome = ./gnome.nix;
    nyxt = ./nyxt.nix;
  };
}
