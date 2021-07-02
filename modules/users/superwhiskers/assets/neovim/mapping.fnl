;;;; mapping.fnl - key mappings
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

(module config.mapping {autoload {nvim aniseed.nvim}})

(defn- noremap [mode from to] "Create a mapping without recursive mapping"
       (nvim.set_keymap mode from to {:noremap true}))

(defn- map [mode from to] "Create a mapping" (nvim.set_keymap mode from to {}))

;;; allow <Esc> to be used to exit terminal mode

(noremap :t :<Esc> "<C-\\><C-n>")

;;; improve switching between buffers

(noremap :n :<C-j> :<C-w>j)
(noremap :n :<C-k> :<C-w>k)
(noremap :n :<C-h> :<C-w>h)
(noremap :n :<C-l> :<C-w>l)

;;; let <C-n> be used to open nerdtree

(noremap :n :<C-n> ":NERDTreeToggle<CR>")

;;; incsearch mappings

(map :n "/" "<Plug>(incsearch-easymotion-/)")
(map :n "?" "<Plug>(incsearch-easymotion-?)")
(map :n :g/ "<Plug>(incsearch-easymotion-stay)")
