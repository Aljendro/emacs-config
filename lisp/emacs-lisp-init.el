;;;; Emacs Lisp Initialization

(maybe-require-package 'smartparens)
(maybe-require-package 'rainbow-delimiters)

(add-hook 'emacs-lisp-mode-hook 'smartparens-strict-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(provide 'emacs-lisp-init)
