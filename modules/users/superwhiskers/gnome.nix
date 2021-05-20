# gnome.nix - gnome/gtk configuration
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
  # gtk configuration
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme.name = "Adwaita-dark";
  };

  # gnome-terminal configuration
  programs.gnome-terminal = {
    enable = true;
    profile."b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
      default = true;
      visibleName = "superwhiskers";
      audibleBell = false;
      colors = {
        backgroundColor = "#2c2525";
        foregroundColor = "#fff1f3";
        cursor = {
          foreground = "#2c2525";
          background = "#fff1f3";
        };
        highlight = {
          foreground = "#2c2525";
          background = "#fff1f3";
        };
        palette = [
          "#2c2525"
          "#fd6883"
          "#adda78"
          "#f9cc6c"
          "#f38d70"
          "#a8a9eb"
          "#85dacc"
          "#fff1f3"
          "#72696a"
          "#fd6883"
          "#adda78"
          "#f9cc6c"
          "#f38d70"
          "#a8a9eb"
          "#85dacc"
          "#fff1f3"
        ];
      };
      cursorBlinkMode = "off";
      cursorShape = "block";
      showScrollbar = false;
      scrollOnOutput = false;
    };
  };

  dconf.settings = {
    # interface settings
    "org/gnome/desktop/interface" = {
      document-font-name = "Inter 11";
      font-antialiasing = "rgba";
      font-hinting = "slight";
      font-name = "Inter 11";
      monospace-font-name = "Go Mono 10";
    };

    # wallpaper settings
    "org/gnome/desktop/background" = {
      picture-uri = builtins.path {
        path = ./assets/gnome/wallpaper.png;
        name = "wallpaper.png";
      };
      picture-options = "zoom";
    };

    # touchpad settings
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = false;
      two-finger-scrolling-enabled = true;
    };

    # forcefully disable the location tracking
    "org/gnome/system/location".enabled = false;

    # make the legacy titlebar font be similar to the rest
    "org/gnome/desktop/wm/preferences".titlebar-font = "Inter Bold 11";

    # disable the gnome software search provider
    #
    # ideally, the gnome software store would be removable,
    # but there appears to be no sane way to remove it, sadily
    # TODO: find a way to properly remove it
    "org/gnome/desktop/search-providers".disabled =
      lib.hm.gvariant.mkArray lib.hm.gvariant.type.string
      [ "org.gnome.Software.desktop" ];
  };
}
