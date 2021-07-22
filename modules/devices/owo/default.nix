# owo.nix - configuration specific to the device bearing the hostname "owo"
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
  # use the mainline kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # make the device boot faster
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # use the ondemant cpu frequency governor
  powerManagement.cpuFreqGovernor = "ondemand";

  # set the hostname
  networking.hostName = "owo";

  # enable the wireless and wired network interfaces
  networking.interfaces = {
    eth0.useDHCP = true;
    wlan0.useDHCP = true;
  };

  # configure nftables instead of using the built-in firewall
  networking.firewall.enable = false;
  networking.nftables = {
    enable = true;
    rulesetFile = ./nftables.conf;
  };

  # allow mosh system-wide
  environment.systemPackages = [ pkgs.mosh ];

  # configure the swap device
  swapDevices = [{ label = "SWAP"; }];

  # configure partitioning
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  # enable syncthing
  services.syncthing.enable = true;

  # enable zram
  zramSwap.enable = true;
}
