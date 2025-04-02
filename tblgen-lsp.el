;;; tblgen-lsp.el --- Description -*- lexical-binding: t; -*-
;;
;; Package-Requires: ((emacs "28.1"))
;; Version: 1
;; URL: https://github.com/gibrane/llvm-mode
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;  LSP client to use with `tablegen-mode' that uses `tblgen-lsp-server' or any
;;  user made compatible server.
;;
;;
;;; Code:
(require 'lsp-mode)

(defgroup tblgen-lsp nil
  "LSP support for Tablegen."
  :group 'lsp-mode
  :link '(url-link "https://mlir.llvm.org/docs/Tools/MLIRLSP/"))

(defcustom tblgen-lsp-server-executable "tblgen-lsp-server"
  "Command to start the mlir language server."
  :group 'tblgen-lsp
  :risky t
  :type 'file)


(defcustom tblgen-lsp-server-args ""
  "Args of LSP client for TableGen, for example
   '--tablegen-compilation-database=.../build/tablegen_compile_commands.yml'"
  :group 'tblgen-lsp
  :risky t
  :type 'file)

(defun tblgen-lsp-setup ()
  "Setup the LSP client for TableGen."
  (add-to-list 'lsp-language-id-configuration '(tablegen-mode . "tablegen"))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection (lambda () (cons tblgen-lsp-server-executable (split-string-shell-command tblgen-lsp-server-args))))
    :activation-fn (lsp-activate-on "tablegen")
    :priority -1
    :server-id 'tblgen-lsp)))

(provide 'tblgen-lsp)
;;; tblgen-lsp.el ends here
