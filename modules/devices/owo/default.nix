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

  # enable the wireless network interface
  networking.interfaces.wlan0.useDHCP = true;

  # configure nftables instead of using the built-in firewall
  networking.firewall.enable = false;
  networking.nftables = {
    enable = true;
    rulesetFile = ./nftables.conf;
  };

  # configure sshd
  services.openssh = {
    enable = true;
    openFirewall = false;
    kexAlgorithms = [ "curve25519-sha256@libssh.org" ];
    ciphers = [
      "chacha20-poly1305@openssh.com"
      "aes256-gcm@openssh.com"
      "aes128-gcm@openssh.com"
      "aes256-ctr"
      "aes192-ctr"
      "aes128-ctr"
    ];
    macs = [
      "hmac-sha2-512-etm@openssh.com"
      "hmac-sha2-256-etm@openssh.com"
      "umac-128-etm@openssh.com"
    ];
    passwordAuthentication = false;
    permitRootLogin = "no";
    challengeResponseAuthentication = false;
    extraConfig = ''
      # force the session key to be regenerated after either 100 kilobytes of data
      # are transmitted or an hour has passed

      RekeyLimit 100K 30m

      # disable compression for security reasons

      Compression no

      # don't read the user's ~/.rhosts and ~/.shosts files

      IgnoreRhosts yes

      # harden the login parameters

      LoginGraceTime 2m
      StrictModes yes
      MaxAuthTries 1
      MaxSessions 10

      # disable additional authentication methods

      HostbasedAuthentication no
      RhostsRSAAuthentication no
      PermitEmptyPasswords no
      UsePAM no

      # additional forwarding configuration

      AllowStreamLocalForwarding all
      AllowTCPForwarding yes
    '';
  };

  # allow mosh system-wide
  environment.systemPackages = [ pkgs.mosh ];

  # configure partitioning
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  # enable zram
  zramSwap.enable = true;
}
