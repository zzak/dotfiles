(global-set-key (kbd "C-x g") 'magit-status)

(setq indent-tab-mode nil)

(setq make-backup-files nil)

(dolist (l (directory-files (concat user-emacs-directory "packages") nil "^[^\.]"))
  (add-to-list 'load-path (concat user-emacs-directory "packages/" l))
(autoload (intern l) (concat l ".el")))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
