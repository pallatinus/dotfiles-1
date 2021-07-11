# default.nix - root categories directory attribute set
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

{ provideInputs, ... }:
provideInputs {
  gnome = import ./gnome.nix;
  audio = import ./audio.nix;
  network = import ./network.nix;
  fonts = import ./fonts.nix;
  nix = import ./nix.nix;
  home-manager = import ./home-manager.nix;
  internationalization = import ./internationalization.nix;
  gnupg = import ./gnupg.nix;
  printing = import ./printing.nix;
  neovim = import ./neovim.nix;
  boot = import ./boot.nix;
  shell = import ./shell.nix;
}
