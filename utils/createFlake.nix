# createFlake.nix - configuration outputs generation function
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

{ self, nixpkgs, ... }:
hosts:
let
  lib = nixpkgs.lib;
  modules = modules.nixosModules;

  revision = _: {
    configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
  };

  hostToSystem = _: host: lib.makeOverridable lib.nixosSystem host;
in { nixosConfigurations = builtins.mapAttrs hostToSystem hosts; }
