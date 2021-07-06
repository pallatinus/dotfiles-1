# neovim.nix - user neovim install configuration
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
  # configure the neovim editor
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # colorscheme
      vim-monokai-pro

      # used for writing the configuration in a lisp
      aniseed

      # utility plugins
      neoformat
      lightline-vim
      vim-startify
      direnv-vim
      easymotion
      incsearch-vim
      incsearch-easymotion-vim
      vim-cool
      quick-scope
      sleuth
      vim-pandoc
      nvim-colorizer-lua
      nvim-treesitter-context
      nvim-treesitter-refactor
      vim-vinegar
      vim-dirvish
      vim-eunuch

      # syntax plugins
      nvim-treesitter
      vim-pandoc-syntax
      vim-nix
    ];
    extraConfig = ''
      let g:aniseed#env = { "module": "config.init" }
    '';
    extraPackages = with pkgs; [ gcc ];
  };

  # provide the fennel configuration files to neovim
  xdg.configFile = lib.mapAttrs' (name: _: {
    name = "nvim/fnl/config/" + name;
    value.source = ./assets/neovim + ("/" + name);
  }) (builtins.readDir ./assets/neovim);
}
