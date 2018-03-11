(global-set-key (kbd "C-x g") 'magit-status)

;; Mitigate Bug#28350 (security) in Emacs 25.2 and earlier.
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

(setq indent-tab-mode nil)

(global-linum-mode t)
(setq linum-format "%4d ")

(setq make-backup-files nil)

(setq-default word-wrap t)

(setq menu-bar-mode -1)

(setq-default show-trailing-whitespace t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(dolist (l (directory-files "~/.emacs.d/packages" nil "^[^\.]"))
  (add-to-list 'load-path (concat "~/.emacs.d/packages/" l))
  (autoload (intern l) (concat "~/.emacs.d/packages/" l ".el")))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'clojure-mode-hook          #'clojure-enable-monroe)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

(require 'elixir-mode)
(require 'alchemist)
(require 'rust-mode)
(require 'yaml-mode)
(require 'clojure-mode)
(require 'monroe)
(require 'paredit)

(setq gofmt-command "goimports")
(require 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)
(require 'go-rename)
