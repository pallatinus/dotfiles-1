# packages.nix - packages with little-to-no configuration that don't fit elsewhere
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

{ pkgs, lib, ... }:
let
  multimc-with-jdk11 = pkgs.multimc.overrideAttrs (oldAttrs: {
    postPatch = oldAttrs.postPatch + ''
      substituteInPlace api/logic/java/JavaUtils.cpp \
        --replace 'scanJavaDir("/usr/java")' 'javas.append("${pkgs.jdk11}/lib/openjdk/bin/java")'
    '';
  });
in {
  # user packages
  home.packages = (lib.attrVals [
    # networking
    "ungoogled-chromium"
    "tor-browser-bundle-bin"
    "mullvad-vpn"

    # communication
    "tdesktop"
    "weechat"
    "element-desktop"
    "nicotine-plus"

    # multimedia (TODO: put this in multimedia.nix with declarative configuration)
    "musikcube"

    # productivity
    "anki"
    "keepassxc"
    "gimp"
    "rx"
    "blender"

    # finance
    "electrum"
    "monero-gui"

    # utilities
    "tokei"
    "pavucontrol"
  ] pkgs) ++ [
    # gaming
    multimc-with-jdk11

    # TODO: fetch using flake from https://github.com/anna328p/tilp-nix/archive/master.tar.gz
    # "tilp"
  ];

  # enable fontconfig
  fonts.fontconfig.enable = true;

  # enable the syncthing file synchronization tool
  services.syncthing.enable = true;

  # enable the zathura document viewer
  programs.zathura = {
    enable = true;
    options = { selection-clipboard = "clipboard"; };
  };

  # configure the git version control system
  programs.git = {
    enable = true;
    userEmail = "whiskerdev@protonmail.com";
    userName = "superwhiskers";
    signing = {
      key = "0134BBC54141A521";
      signByDefault = true;
    };
  };
}
