;;;; Clojure Initialization

(when (maybe-require-package 'clojure-mode)

  (require-package 'cider)
  (require-package 'eldoc)
  (require-package 'company)
  (require-package 'smartparens)
  (require-package 'rainbow-delimiters)
  (require-package 'clj-refactor)

  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook #'cider-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'smartparens-strict-mode)
  (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
  (add-hook 'clojure-mode-hook
	    (lambda ()
		(clj-refactor-mode 1)
		;; This choice of keybinding leaves cider-macroexpand-1 unbound
		(cljr-add-keybindings-with-prefix "C-c C-m"))))

(provide 'clojure-init)



