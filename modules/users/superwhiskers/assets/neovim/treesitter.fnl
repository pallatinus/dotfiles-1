;;;; treesitter.fnl - nvim-treesitter configuration
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

(module config.treesitter
        {autoload {treesitter nvim-treesitter.configs
                   treesitter-context treesitter-context.config
                   nvim aniseed.nvim}})

;;; setup nvim-treesitter

(treesitter.setup {:ensure_installed :maintained
                   :highlight {:enable true}
                   :indent {:enable true}
                   :incremental_selection {:enable true}
                   :refactor {:smart_rename {:enable true}
                              :navigation {:enable true}}})

;;; enable nvim-treesitter-context

(treesitter-context.setup {:enable true})
