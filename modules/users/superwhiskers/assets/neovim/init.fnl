;;;; init.fnl - user neovim configuration
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

(module config.init
  {autoload {nvim aniseed.nvim}
   require-macros [config.macros]})

(require :config.display)
(require :config.mapping)
(require :config.nerdtree)
(require :config.lightline)
(require :config.startify)
(require :config.neoformat)
(require :config.quick-scope)

;;; generic

(nvim.ex.set :hidden)                  ; keep buffers open in the background
(nvim.ex.filetype :plugin :indent :on) ; enable filetype detection, plugins, and indentation
(nvim.ex.syntax :enable)               ; enable syntax highlighting
(set nvim.o.modelines 0)               ; disable modelines
(nvim.ex.set :wrap)                    ; enable line wrapping

;;; textwidth

;;; TODO: look into handling this by making a macro that takes an sexpr and anonymously defines it
(defn markdown-set-textwidth []
  (set nvim.bo.textwidth 99))

(augroup :markdown_textwidth
         ;; set textwidth to 99 in markdown files
         (autocmd :FileType "markdown" (viml->fn markdown-set-textwidth)))
