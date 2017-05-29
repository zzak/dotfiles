(global-set-key (kbd "C-x g") 'magit-status)

(setq indent-tab-mode nil)

(setq make-backup-files nil)

(setq-default word-wrap t)

(setq menu-bar-mode -1)

(setq-default show-trailing-whitespace t)

(dolist (l (directory-files "~/.emacs.d/packages" nil "^[^\.]"))
  (add-to-list 'load-path (concat "~/.emacs.d/packages/" l))
  (autoload (intern l) (concat "~/.emacs.d/packages/" l ".el")))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(require 'elixir-mode)
(require 'alchemist)
(require 'rust-mode)
(require 'yaml-mode)
(require 'monroe)
(add-hook 'clojure-mode-hook 'clojure-enable-monroe)
