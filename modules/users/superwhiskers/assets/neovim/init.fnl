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

(module config.init {autoload {nvim aniseed.nvim}
                     require-macros [config.macros]})

(require :config.display)
(require :config.mapping)
(require :config.lightline)
(require :config.startify)
(require :config.neoformat)
(require :config.quick-scope)
(require :config.treesitter)

;;; generic

(nvim.ex.set :hidden)
(nvim.ex.filetype :plugin :indent :on)
(nvim.ex.syntax :enable)
(set nvim.o.modelines 0)
(nvim.ex.set :wrap)

;;; set filetype for zig files
(autocmd "BufRead,BufNewFile" :*.zig (inline-foreign (set nvim.bo.filetype :zig)))
(autocmd "BufRead,BufNewFile" :*.zir (inline-foreign (set nvim.bo.filetype :zir)))

;;; textwidth

(augroup :formatted_textwidth ;; set textwidth to 99 in formatted text files
         (autocmd :FileType "markdown,pandoc"
                  (inline-foreign (set nvim.bo.textwidth 99))))
