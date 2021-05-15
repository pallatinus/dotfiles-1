# t440p.nix - thinkpad t440p-specific configuration
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

{ config, pkgs, ... }: {
  # kernel-level configuration
  boot = {
    # bootloader configuration
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # kernel module configuration
    kernelModules = [ "acpi_call" "kvm-intel" ];
    initrd = {
      kernelModules = [ "i915" ];
      availableKernelModules = [
        "xhci_pci"
        "ehci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "sr_mod"
        "rtsx_pci_sdmmc"
      ];
    };
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    # swappiness value adjustment
    kernel.sysctl."vm.swappiness" = 10;
  };

  # enable the trackpoint
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
  };

  # fix to make the trackpad to work after suspend
  powerManagement = {
    powerDownCommands = "${pkgs.kmod}/bin/modprobe -r psmouse";
    resumeCommands = "${pkgs.kmod}/bin/modprobe psmouse";
  };

  # allow the hard disk head to be stopped when the device is falling
  services.hdapsd.enable = true;

  # keep the cpu microcode up to date
  hardware.cpu.intel.updateMicrocode = true;

  # allow redistributable firmware
  hardware.enableRedistributableFirmware = true;

  # enable opengl
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  # disable the nvidia gpu
  hardware.nvidiaOptimus.disable = true;

  # fix the xserver dpi
  services.xserver.dpi = 75;
}
