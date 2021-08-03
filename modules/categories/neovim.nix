# neovim.nix - system neovim install configuration
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

{ neovim-nightly-overlay, ... }:
{ pkgs, ... }: {
  # add the nightly nixpkgs overlay
  nixpkgs.overlays = [ neovim-nightly-overlay.overlay ];

  # enable and make neovim the default editor
  programs.neovim = {
    # TODO: disabled because of the following issue
    #       https://github.com/NixOS/nixpkgs/issues/132389
    # enable = true;

    package = pkgs.neovim-nightly;
    defaultEditor = true;
  };
}
