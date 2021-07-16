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
  fnlfmt = pkgs.stdenv.mkDerivation rec {
    name = "fnlfmt";
    version = "0.2.1";
    patchPhase = ''
      patchShebangs ./fennel
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp fnlfmt $out/bin
    '';
    src = pkgs.fetchFromSourcehut {
      owner = "~technomancy";
      repo = "fnlfmt";
      rev = version;
      hash = "sha256-JIqeQhI3fFGrej2wbj6/367IZqWAFegySc2R8IDmvGE=";
    };
    buildInputs = lib.attrVals [ "lua" ] pkgs;
  };
in {
  # user packages
  home.packages = builtins.attrValues {
    inherit (pkgs)
      ungoogled-chromium tor-browser-bundle-bin mullvad-vpn # networking

      tdesktop weechat element-desktop nicotine-plus # communication

      musikcube # multimedia

      anki keepassxc gimp rx blender # productivity

      electrum # finance

      nixfmt xsv tokei lftp htop ripgrep nnn pavucontrol mosh; # utilities

    inherit (pkgs.gnome)
      gnome-tweak-tool gnome-shell-extensions dconf-editor; # utilities
  } ++ [
    # gaming
    multimc-with-jdk11

    # utilities
    fnlfmt

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
