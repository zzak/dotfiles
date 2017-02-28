(global-set-key (kbd "C-x g") 'magit-status)

`(setq indent-tab-mode nil)`

(let ((default-directory  "~/.emacs.d/packages/"))
  (normal-top-level-add-subdirs-to-load-path))

(dolist (l (directory-files (concat user-emacs-directory "packages") nil "^[^\.]"))
  (add-to-list 'load-path (concat user-emacs-directory "packages/" l))
(autoload (intern l) (concat l ".el")))

;;(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
