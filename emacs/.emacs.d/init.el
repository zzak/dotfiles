(global-set-key (kbd "C-x g") 'magit-status)

(setq indent-tab-mode nil)

(setq make-backup-files nil)

(dolist (l (directory-files "~/.emacs.d/packages" nil "^[^\.]"))
  (add-to-list 'load-path (concat "~/.emacs.d/packages/" l))
  (autoload (intern l) (concat "~/.emacs.d/packages/" l ".el")))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(require 'elixir-mode)
(require 'alchemist)
(require 'rust-mode)