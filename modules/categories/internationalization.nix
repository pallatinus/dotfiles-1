# internationalization.nix - configuration of timezones and the keyboard layout
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

{
  # set the timezone
  time.timeZone = "America/Chicago";

  # set the xserver keymap
  services.xserver = {
    layout = "us";
    xkbVariant = "dvp";
  };

  # set the locale
  i18n = {
    # the default locale is english utf-8
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      # for time, use the c utf-8 locale to get 24h timestamps
      LC_TIME = "C.UTF-8";
    };
  };

  # set the console keymap
  console.keyMap = "dvorak-programmer";
}
