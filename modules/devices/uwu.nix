# uwu.nix - configuration specific to the device bearing the hostname "uwu"
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

{ pkgs, ... }: {
  # use the xanmod kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod;

  # use the ondemand cpu frequency governor
  powerManagement.cpuFreqGovernor = "ondemand";

  # network interface configuration
  networking = {
    hostName = "uwu";
    interfaces = {
      enp0s25.useDHCP = true;
      wlan0.useDHCP = true;
    };
  };

  # we don't want networkmanager to mess with our dns settings
  networking.networkmanager.dns = "none";

  # set the domain name resolver
  networking.nameservers =
    [ "155.138.240.237" "2001:19f0:6401:b3d:5400:2ff:fe5a:fb9f" ];

  # change some settings on the firewall
  networking.firewall = {
    # necessary to make mullvad work (?)
    checkReversePath = false;

    # expose the port used for slsk
    allowedTCPPorts = [ 58868 ];
  };

  # enable mullvad
  services.mullvad-vpn.enable = true;

  # disable nixos-help
  documentation.nixos.enable = false;

  # make the numworks and android udev rules available
  services.udev.packages = with pkgs; [
    numworks-udev-rules
    android-udev-rules
  ];

  # enable flatpak
  services.flatpak.enable = true;

  # configure partitioning
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/68be6398-3103-4565-9c73-e21c0b4a0c0e";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/A300-92C8";
      fsType = "vfat";
      options = [ "noatime" ];
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/fb641a7c-1151-4a67-b195-06708bf627fc"; }];
}
