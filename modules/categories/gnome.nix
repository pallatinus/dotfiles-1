# gnome.nix - configuration of the gnome desktop environment
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
  # enable gnome in the system configuration
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      wayland = true;
      enable = true;
    };
  };

  # disable a bunch of gnome services
  services.gnome = {
    gnome-online-accounts.enable = false;
    gnome-remote-desktop.enable = false;
    gnome-initial-setup.enable = false;
    chrome-gnome-shell.enable = false;
  };

  # disable the geoclue service
  services.geoclue2.enable = false;

  # remove a bunch of packages included by default
  environment.gnome.excludePackages = with pkgs.gnome3; [
    baobab
    cheese
    eog
    epiphany
    gedit
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    pkgs.gnome-photos
    gnome-screenshot
    gnome-system-monitor
    gnome-weather
    pkgs.gnome-connections
    totem
    yelp
    evince
    file-roller
    geary
    gnome-disk-utility
    gnome-terminal
    seahorse
    sushi
  ];
}
