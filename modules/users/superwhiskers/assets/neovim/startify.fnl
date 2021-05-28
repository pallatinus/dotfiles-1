;;;; startify.fnl - startify configuration
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

(module config.startify
  {autoload {nvim aniseed.nvim}}) 

;;; ensure that startify is loaded

(nvim.ex.packadd :vim-startify)

;;; configure the start screen

(set nvim.g.startify_lists [{:type "files"
                             :header (nvim.fn.startify#pad ["most recently opened"])}
                            {:type "dir"
                             :header (nvim.fn.startify#pad [(..
                                                              "most recently opened in "
                                                              (nvim.fn.getcwd))])}
                            {:type "bookmarks"
                             :header (nvim.fn.startify#pad ["bookmarks"])}])
(set nvim.g.startify_custom_header (nvim.fn.startify#pad ["neovim"]))
