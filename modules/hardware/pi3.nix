# pi3.nix - raspberry pi3-specific configuration
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
  # kernel configuration
  boot = {
    # bootloader configuration
    loader = {
      grub.enable = false;
      raspberryPi = {
        enable = true;
        version = 3;
        uboot.enable = true;
        firmwareConfig = ''
          start_x=1
        '';
      };
    };

    # configure wireless regulatory information
    extraModprobeConfig = ''
      options cf680211 ieee80211_regdom="US"
    '';

    # kernel module configuration
    # (we only ever use the mainline kernel)
    initrd.kernelModules = [ "vc4" "bcm2835_dma" "i2c_bcm2835" ];
  };

  hardware = {
    # allow redistributable firmware to be used
    enableRedistributableFirmware = true;

    # add the regulatory information package
    firmware = lib.attrVals [ "wireless-regdb" ] pkgs;
  };
}
