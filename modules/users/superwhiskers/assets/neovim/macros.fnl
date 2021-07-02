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

(fn augroup [name ...]
  "Shorthand for defining an autogroup"
  `(do
     (nvim.ex.augroup ,(tostring name))
     (nvim.ex.autocmd_)
     ,(list `do ...)
     (nvim.ex.augroup :END)))

(fn autocmd [...]
  "Shorthand for nvim.ex.autocmd"
  `(nvim.ex.autocmd ,...))

(fn foreign [name]
  "Insert a call to a fennel function from vim"
  `(.. "lua require('" *module-name* "')['" ,(tostring name) "']()"))

(fn inline-foreign [...]
  "Wrap the enclosed S-expressions in a function and insert a call to them from vim"
  (let [fun (gensym)]
    `(do
       (defn ,fun [] ,(list `do ...))
       (.. "lua require('" *module-name* "')['" ,(tostring fun) "']()"))))

{: augroup : autocmd : foreign : inline-foreign}
