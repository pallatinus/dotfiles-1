# network.nix - general network stack configuration
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
{ lib, ... }: {
  # configure and enable networkmanager
  networking = {
    wireless.enable = false;

    networkmanager = {
      enable = true;

      # iwd is more modern
      wifi.backend = "iwd";
    };

    # this is discouraged (but enabled by default?)
    useDHCP = false;

    # for some reason, this is enabled by default
    dhcpcd.enable = lib.mkDefault false;

    # custom nameservers
    nameservers = [ "155.138.240.237" "2001:19f0:6401:b3d:5400:2ff:fe5a:fb9f" ];
  };
}
