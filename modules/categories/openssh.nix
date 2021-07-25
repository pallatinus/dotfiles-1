# openssh.nix - hardened openssh configuration
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

_: {
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
      PermitEmptyPasswords no
      UsePAM no

      # additional forwarding configuration

      AllowStreamLocalForwarding all
      AllowTCPForwarding yes
    '';
  };
}
