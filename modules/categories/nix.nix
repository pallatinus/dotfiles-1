# nix.nix - configuration relating to the nix package manager
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

_:
{ pkgs, lib, ... }: {
  nix = {
    # use the unstable version of nix
    package = pkgs.nixUnstable;

    # use cache v2
    # https://www.notion.so/NEW-Try-the-beta-cache-5263cdd5200b4e328baf41f904e6f5ee
    binaryCaches = [ "https://aseipp-nix-cache.freetls.fastly.net" ];

    # enable the flake feature
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
    '';

    # enable garbage collection once a week
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };

    # enable automatic store optimization 
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
  };

}
