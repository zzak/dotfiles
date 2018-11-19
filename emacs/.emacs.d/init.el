;; Mitigate Bug#28350 (security) in Emacs 25.2 and earlier.
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

(setq indent-tab-mode nil)

(global-linum-mode t)
(setq linum-format "%4d ")
(setq column-number-mode t)

(setq make-backup-files nil)

(setq-default word-wrap t)

(menu-bar-mode -1)

(winner-mode)

(setq-default show-trailing-whitespace t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2)))

(windmove-default-keybindings 'meta)
;(global-set-key (kbd "C-c <left>")  'windmove-left)
;(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<down>")  'windmove-down)

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
(eval-after-load "paredit" #'(show-paren-mode))

(autoload 'rainbow-delimiters-mode "rainbow-delimiters" "Emacs rainbow delimiters mode" t)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(add-hook 'prog-mode-hook #'ggtags-mode)

(require 'elixir-mode)
(require 'alchemist)
(require 'rust-mode)
(require 'yaml-mode)
(require 'clojure-mode)
(require 'monroe)
(require 'paredit)
(require 'rainbow-delimiters)
(require 'ggtags)
(require 'projectile)
(require 'tide)
(require 'web-mode)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(define-key paredit-mode-map (kbd "M-<up>") nil)
(define-key paredit-mode-map (kbd "M-<down>") nil)

(projectile-mode)

(eval-after-load 'projectile
  '(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
(eval-after-load 'projectile
  '(define-key projectile-mode-map (kbd "C-c f") 'projectile-find-file))

(add-to-list 'load-path "~/.emacs.d/packages/magit/lisp")
(load "~/.emacs.d/packages/magit/lisp/magit.el")
(global-set-key (kbd "C-x g") 'magit-status)

(setq gofmt-command "goimports")
(require 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)
(require 'go-rename)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(defun timestamp () (interactive)
       (insert (format-time-string "%Y-%m-%dT%H:%M:%S")))

;; Thanks phil ;)
(defvar clj-last-test "user")
(defvar clj-run-test-lib 'clojure.test/run-tests)
(defvar clj-test-var-lib 'clojure.test/test-var)

(defun clj-run-tests (run-last)
  (interactive "P")
  (monroe-eval-buffer)
  (monroe-send-eval-string
   (format "%s" `(,clj-run-test-lib
                  (quote ,(if run-last
                              clj-last-test
                            (setq clj-last-test (clojure-find-ns))))))
   (monroe-make-response-handler)))

(eval-after-load 'clojure-mode
  '(define-key clojure-mode-map (kbd "C-c C-t") 'clj-run-tests))

(defun clj-run-focused-test ()
  (interactive)
  (monroe-eval-buffer)
  (monroe-send-eval-string
   (format "%s" `(,clj-test-var-lib *1))
   (monroe-make-response-handler)))

(eval-after-load 'clojure-mode
  '(define-key clojure-mode-map (kbd "C-c t") 'clj-run-focused-test))
