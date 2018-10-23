;;;; Global Initialization

;; Add Melpa Stable to 'package-archives
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))


(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))

;; Global settings
(set-face-attribute 'default nil :height 150) ;; Font size
(load-theme 'monokai t)
(global-display-line-numbers-mode)

;; Turn on global packages
(when (maybe-require-package 'use-package))

(when (maybe-require-package 'which-key)
  (which-key-mode))

(when (maybe-require-package 'neotree)
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-smart-open t))

(when (maybe-require-package 'avy)
  (global-set-key (kbd "s-2") 'avy-goto-char))

(when (maybe-require-package 'helm)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files))

(when (maybe-require-package 'yasnippet)
  (yas-global-mode))

(when (maybe-require-package 'projectile)
  (projectile-global-mode)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(when (maybe-require-package 'smartparens)

  (require 'smartparens-config)
  
  (sp-with-modes (cons 'clojure-repl-mode sp--lisp-modes)
    ;; disable ', it's the quote character!
    (sp-local-pair "'" nil :actions nil)
    ;; also only use the pseudo-quote inside strings where it serve as
    ;; hyperlink.
    (sp-local-pair "`" "'" :when '(sp-in-string-p sp-in-comment-p))
    (sp-local-pair "`" nil
                   :skip-match (lambda (ms mb me)
				 (cond
                                  ((equal ms "'")
                                   (or (sp--org-skip-markup ms mb me)
                                       (not (sp-point-in-string-or-comment))))
                                  (t (not (sp-point-in-string-or-comment)))))))

  ;; Some s-expression manipulation keybindings
  (bind-keys
   :map smartparens-mode-map
   ("C-s-<right>" . sp-forward-slurp-sexp)
   ("C-s-<left>" . sp-forward-barf-sexp)
   ("C-M-<left>"  . sp-backward-slurp-sexp)
   ("C-M-<right>"  . sp-backward-barf-sexp)

   ("M-s-t" . sp-transpose-sexp)
   ("M-s-k" . sp-kill-sexp)
   ("C-k"   . sp-kill-hybrid-sexp)
   ("M-k"   . sp-backward-kill-sexp)
   ("M-s-w" . sp-copy-sexp)
   ("M-s-d" . delete-sexp)

   ("M-<backspace>" . backward-kill-word)
   ("C-<backspace>" . sp-backward-kill-word)
   ([remap sp-backward-kill-word] . backward-kill-word)
   
   ("M-[" . sp-backward-unwrap-sexp)
   ("M-]" . sp-unwrap-sexp)

   ("C-x C-t" . sp-transpose-hybrid-sexp)

   ("C-c ("  . wrap-with-parens)
   ("C-c ["  . wrap-with-brackets)
   ("C-c {"  . wrap-with-braces)
   ("C-c '"  . wrap-with-single-quotes)
   ("C-c \"" . wrap-with-double-quotes)
   ("C-c _"  . wrap-with-underscores)
   ("C-c `"  . wrap-with-back-quotes)))


(provide 'global-init)

