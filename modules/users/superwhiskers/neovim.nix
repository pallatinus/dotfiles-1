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
      nerdtree
      vim-cool
      quick-scope

      # syntax plugins
      vim-polyglot
    ];
    extraConfig = ''
      auto!

      " configuration is handled through a fennel file
      let g:aniseed#env = { "input": "" }

      " -- everything after this should be removed

      " keep buffers open even if a new file is open
      set hidden

      " some language servers have issues with backup files
      set nobackup
      set nowritebackup

      " make syntax highlighting work
      filetype plugin indent on
      syntax enable

      " line number handling
      set number
      augroup number_terminal
        auto!
        auto TermEnter * set nonumber
        auto TermLeave * set number
      augroup END

      " disable modelines for security reasons
      set modelines=0

      " allow usage of <Esc> to exit terminal mode
      tnoremap <Esc> <C-\><C-n>

      " allow :W to save the file using `sudo`
      command! W execute 'w !sudo -S tee % > /dev/null' <bar> edit!

      " make tabs be 2 spaces
      set tabstop=2
      set shiftwidth=2
      set expandtab

      " configure leader key
      let mapleader = ","
      nmap <leader>w :w!<CR>

      " better window movement
      map <C-j> <C-W>j
      map <C-k> <C-W>k
      map <C-h> <C-W>h
      map <C-l> <C-W>l

      " configure line mode
      set listchars=eol:↵,tab:··,space:·
      set list

      " configure wrapping
      set wrap
      set lbr

      " set textwidth to 99 in markdown files
      augroup markdown_textwidth
        autocmd!
        autocmd FileType markdown setlocal textwidth=99
      augroup end

      " configure the theme
      set background=dark
      set termguicolors
      colorscheme monokai_pro

      " configure nerdtree to open when a directory list is requested
      autocmd StdinReadPre * let s:std_in=1
      autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

      " configure nerdtree's arrows
      let g:NERDTreeDirArrowExpandable = '→'
      let g:NERDTreeDirArrowCollapsible = '↓'

      " remove the bookmarks label and the help text from nerdtree
      let g:NERDTreeMinimalUI = 1

      " map C-n to nerdtree
      map <C-n> :NERDTreeToggle<CR>

      " configure js highlighting
      let g:javascript_plugin_jsdoc = 1
      let g:javascript_plugin_flow = 1

      " configure haskell highlighting and indentation
      let g:haskell_enable_quantification = 1
      let g:haskell_enable_recursivedo = 1
      let g:haskell_enable_arrowsyntax = 1
      let g:haskell_enable_pattern_synonyms = 1
      let g:haskell_enable_typeroles = 1
      let g:haskell_enable_static_pointers = 1
      let g:haskell_backpack = 1
      let g:haskell_indent_disable = 1

      " configure rust.vim to copy playpen urls to the clipboard properly
      let g:rust_clip_command = 'xclip -selection clipboard'

      " lightline

      " hide stock statusline
      set noshowmode

      " configure lightline
      let g:lightline = {
        \   'separator': {},
        \   'subseparator': {},
        \   'active': {},
        \ }

      let g:lightline.colorscheme = 'monokai_pro'

      let g:lightline.separator = {
        \   'left': ''',
        \   'right': ''',
        \ }
      let g:lightline.subseparator = {
        \   'left': ''',
        \   'right': ''',
        \ }

      let g:lightline.active = {
        \   'left': [
        \     [ 'mode', 'paste' ],
        \     [ 'readonly', 'filename', 'modified' ],
        \   ],
        \ }

      " configure the start screen
      packadd vim-startify
      let g:startify_lists = [
              \ { 'type': 'files',     'header': startify#pad(['most recently opened']) },
              \ { 'type': 'dir',       'header': startify#pad(['most recently opened in ' . getcwd()]) },
              \ { 'type': 'bookmarks', 'header': startify#pad(['bookmarks']) },
              \ ]
      let g:startify_bookmarks = [
                              \ '~/.config/nixpkgs/home.nix',
                              \ ]
      let g:startify_custom_header = startify#pad(['neovim'])

      " configure incsearch
      function! s:incsearch_config(...) abort
        return incsearch#util#deepextend(deepcopy({
        \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
        \   'keymap': {
        \     "\<CR>": '<Over>(easymotion)'
        \   },
        \   'is_expr': 0
        \ }), get(a:, 1, {}))
      endfunction

      noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
      noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
      noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

      " configure neoformat
      let g:neoformat_haskell_ormolu = { 'exe': 'ormolu', 'args': [] }
      let g:neoformat_enabled_haskell = ['ormolu']

      " configure quick-scope
      let g:qs_buftype_blacklist = ['terminal', 'nofile']

      " configure the neovim terminal
      let g:terminal_color_0 = '#2c2525'
      let g:terminal_color_1 = '#fd6883'
      let g:terminal_color_2 = '#adda78'
      let g:terminal_color_3 = '#f9cc6c'
      let g:terminal_color_4 = '#f38d70'
      let g:terminal_color_5 = '#a8a9eb'
      let g:terminal_color_6 = '#85dacc'
      let g:terminal_color_7 = '#fff1f3'
      let g:terminal_color_8 = '#72696a'
      let g:terminal_color_9 = '#fd6883'
      let g:terminal_color_10 = '#adda78'
      let g:terminal_color_11 = '#f9cc6c'
      let g:terminal_color_12 = '#f38d70'
      let g:terminal_color_13 = '#a8a9eb'
      let g:terminal_color_14 = '#85dacc'
      let g:terminal_color_15 = '#fff1f3'
    '';
  };

  # TODO: make this functional instead
  # xdg.configFile = lib.mapAttrs' (name: _: {
  #   name = "nvim/" + name;
  #   value = builtins.readFile ./assets/neovim/ + name;
  # }) (builtins.readDir ./assets/neovim);

  # the real configuration files
  xdg.configFile."nvim/init.fnl".text =
    builtins.readFile ./assets/neovim/init.fnl;
}
