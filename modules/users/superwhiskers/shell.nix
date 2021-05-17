# shell.nix - terminal, shell, and command-line utility configuration
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

{ config, ... }: {
  # enable the alacritty terminal emulator
  programs.alacritty = {
    enable = false;
    settings = {
      window = {
        padding = {
          x = 20;
          y = 20;
        };
      };
      colors = {
        primary = {
          background = "0x2c2525";
          foreground = "0xfff1f3";
        };
        normal = {
          black = "0x2c2525";
          red = "0xfd6883";
          green = "0xadda78";
          yellow = "0xf9cc6c";
          blue = "0xf38d70";
          magenta = "0xa8a9eb";
          cyan = "0x85dacc";
          white = "0xfff1f3";
        };
        bright = {
          black = "0x72696a";
          red = "0xfd6883";
          green = "0xadda78";
          yellow = "0xf9cc6c";
          blue = "0xf38d70";
          magenta = "0xa8a9eb";
          cyan = "0x85dacc";
          white = "0xfff1f3";
        };
      };
    };
  };

  # enable the starship shell prompt
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # enable the direnv environment loader
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    enableNixDirenvIntegration = true;
  };

  # enable the exa ls replacement
  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  # enable the bat cat clone
  programs.bat = {
    enable = true;
    config.theme = "base16";
  };

  # configure the fish shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # general shell variables
      set -x GPG_TTY (tty)
      set -x EDITOR 'nvim'
      set -x GOPATH '${config.xdg.userDirs.documents}/go'

      # erase the greeting
      set fish_greeting

      # make the colorscheme for syntax highlighting match the 16 color palette
      set fish_color_normal white
      set fish_color_command cyan
      set -u fish_color_keyword
      set fish_color_quote yellow
      set fish_color_redirection white
      set fish_color_end white
      set fish_color_error red
      set fish_color_param green
      set fish_color_comment brblack
      set fish_color_operator red
      set fish_color_escape blue
      set fish_color_autosuggestion brblack
      set fish_color_cancel brblack
      set fish_color_search_match --background=green

      set fish_pager_color_progress white
      set fish_pager_color_description yellow
    '';
  };
}
