;;;; Clojure Initialization

(when (maybe-require-package 'clojure-mode)

  (require-package 'cider)
  (require-package 'eldoc)
  (require-package 'company)
  (require-package 'smartparens)
  (require-package 'rainbow-delimiters)

  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook #'cider-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'smartparens-mode)
  (add-hook 'cider-repl-mode-hook #'smartparens-mode))

(provide 'clojure-init)



