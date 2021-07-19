# headless.nix - packages for use on purely headless systems
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
  fnlfmt = let version = "0.2.1";
  in pkgs.stdenv.mkDerivation {
    name = "fnlfmt";
    version = version;
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
  home.packages =
    (lib.attrVals [ "mosh" "xsv" "lftp" "htop" "ripgrep" "nnn" "nixfmt" ] pkgs)
    ++ [
      # consider moving fnlfmt to a flake and moving the install to a shell w/ nix-direnv
      # in this flake
      fnlfmt
    ];
}
