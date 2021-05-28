;;;; display.fnl - neovim configuration related to the display
;;;;
;;;; Permission to use, copy, modify, and/or distribute this software for any
;;;; purpose with or without fee is hereby granted.
;;;;
;;;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
;;;; REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
;;;; AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
;;;; INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
;;;; LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
;;;; OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
;;;; PERFORMANCE OF THIS SOFTWARE.

(module config.display
  {autoload {nvim aniseed.nvim}
   require-macros [config.macros]})

;;; theme

(set nvim.o.background :dark)                    ; use the dark background
(nvim.ex.set :termguicolors)                     ; enable 24-bit color in the terminal
(nvim.ex.colorscheme "monokai_pro")              ; use monokai pro as the theme

;;; terminal

(set nvim.g.terminal_color_0 "#2c2525")
(set nvim.g.terminal_color_1 "#fd6883")
(set nvim.g.terminal_color_2 "#adda78")
(set nvim.g.terminal_color_3 "#f9cc6c")
(set nvim.g.terminal_color_4 "#f38d70")
(set nvim.g.terminal_color_5 "#a8a9eb")
(set nvim.g.terminal_color_6 "#85dacc")
(set nvim.g.terminal_color_7 "#fff1f3")
(set nvim.g.terminal_color_8 "#72696a")
(set nvim.g.terminal_color_9 "#fd6883")
(set nvim.g.terminal_color_10 "#adda78")
(set nvim.g.terminal_color_11 "#f9cc6c")
(set nvim.g.terminal_color_12 "#f38d70")
(set nvim.g.terminal_color_13 "#a8a9eb")
(set nvim.g.terminal_color_14 "#85dacc")
(set nvim.g.terminal_color_15 "#fff1f3")

;;; whitespace

(set nvim.o.listchars "eol:↵,tab:··,space:·")    ; control how some characters are displayed
(nvim.ex.set :list)                              ; enable list mode

;;; line numbers

;;; TODO: same as init.fnl
(defn terminal-set-nonumber []
  (nvim.ex.set :nonumber))

(defn terminal-set-number []
  (nvim.ex.set :number))

(nvim.ex.set :number)                            ; line numbers are enabled by default
(augroup :number_terminal
         ;; disable line numbers upon entering a terminal
         (autocmd :TermEnter :* (viml->fn terminal-set-nonumber))
         (autocmd :TermLeave :* (viml->fn terminal-set-number)))

;;; js highlighting

(set nvim.g.javascript_plugin_jsdoc 1)
(set nvim.g.javascript_plugin_flow 1)

;;; haskell highlighting / indentation

(set nvim.g.haskell_enable_quantification 1)
(set nvim.g.haskell_enable_recursivedo 1)
(set nvim.g.haskell_enable_arrowsyntax 1)
(set nvim.g.haskell_enable_pattern_synonyms 1)
(set nvim.g.haskell_enable_typeroles 1)
(set nvim.g.haskell_enable_static_pointers 1)
(set nvim.g.haskell_indent_disable 1)
(set nvim.g.haskell_backpack 1)
