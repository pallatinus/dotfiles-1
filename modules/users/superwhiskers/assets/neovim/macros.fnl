;;;; macros.fnl - utility macros for neovim
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

;; define an autogroup easily
(fn augroup [name ...]
  `(do
     (nvim.ex.augroup ,(tostring name))
     (nvim.ex.autocmd_)
     ,...
     (nvim.ex.augroup :END)))

;; shorthand for nvim.ex.autocmd
(fn autocmd [...]
  `(nvim.ex.autocmd ,...))

;; shorthand for calling a lua function. useful in autocommands
(fn viml->fn [name]
   `(.. "lua require('" *module-name* "')['" ,(tostring name) "']()"))

{:augroup augroup
 :autocmd autocmd
 :viml->fn viml->fn}
