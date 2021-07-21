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

{ pkgs, lib, ... }: {
  # use the xanmod kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod;

  # make the device boot faster
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # use the ondemand cpu frequency governor
  powerManagement.cpuFreqGovernor = "ondemand";

  # set the hostname
  networking.hostName = "uwu";

  # enable specific network interfaces
  networking.interfaces = {
    enp0s25.useDHCP = true;
    wlan0.useDHCP = true;
  };

  # configure the firewall
  networking.firewall = {
    # necessary to make mullvad work (?)
    checkReversePath = false;

    # expose the port used for slsk
    allowedTCPPorts = [ 59815 ];
  };

  # disable bluetooth
  hardware.bluetooth = {
    enable = false;
    powerOnBoot = false;
  };

  # configure dnsmasq
  /* services.dnsmasq = {
       enable = true;

       # set the dns servers
       servers = [ "155.138.240.237" "2001:19f0:6401:b3d:5400:2ff:fe5a:fb9f" ];
     };
  */

  # enable the mullvad service
  services.mullvad-vpn.enable = true;

  # make the numworks and android udev rules available
  services.udev.packages =
    lib.attrVals [ "numworks-udev-rules" "android-udev-rules" ] pkgs;

  # enable trim
  services.fstrim.enable = true;

  # disable the nvidia gpu
  hardware.nvidiaOptimus.disable = true;

  # enable flatpak
  services.flatpak.enable = true;

  # load the encrypted root partition
  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-partuuid/4da2c499-f09e-9e4e-88a3-98760254bd33";
    allowDiscards = true;
  };

  # configure partitioning
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/0e9b6fe0-1844-4b1a-abf6-6fd49bb47db5";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-partuuid/2db197a4-9dac-9e42-8bbf-2479be6f73e9";
      fsType = "vfat";
      options = [ "noatime" ];
    };
  };
}
