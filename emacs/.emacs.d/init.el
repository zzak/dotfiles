(setq gc-cons-threshold 100000000
      max-lisp-eval-depth 100000
      max-specpdl-size 100000
      read-process-output-max 100000
      treemacs-space-between-root-nodes nil
      company-minimum-prefix-length 1
      lsp-lens-enable nil
      lsp-signature-auto-activate nil
      lsp-modeline-code-actions-enable nil
      lsp-modeline-diagnostics-enable nil
      lsp-file-watch-threshold 10000)

(setq inhibit-startup-screen t)

(setq indent-tab-mode nil)
(setq-default indent-tabs-mode nil)

(global-linum-mode t)
(setq linum-format "%4d ")
(setq column-number-mode t)

(setq make-backup-files nil)

(setq-default word-wrap t)

(menu-bar-mode -1)

(when (memq window-system '(mac ns x))
  (toggle-scroll-bar -1)
  (tool-bar-mode -1))

(winner-mode)

(setq-default show-trailing-whitespace t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(setq default-frame-alist '((font . "Source Code Pro-14")))

;; make emacs work in macos
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'alt)

;; This works for copying, but not pasting for some reason
(setq select-enable-clipboard t)

;; Whatever... it's easy enough to implement that part ourselves
(setq interprogram-paste-function
      (lambda ()
        (shell-command-to-string "pbpaste")))

(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2)))

(windmove-default-keybindings 'meta)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

(dolist (l (directory-files "~/.emacs.d/packages" nil "^[^\.]"))
  (add-to-list 'load-path (concat "~/.emacs.d/packages/" l))
  (autoload (intern l) (concat "~/.emacs.d/packages/" l ".el")))

(require 'exec-path-from-shell)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(when (daemonp)
  (exec-path-from-shell-initialize))

;(add-to-list 'load-path "~/.emacs.d/packages/lsp-mode/clients")
(add-to-list 'load-path "~/.emacs.d/packages/treemacs/src/elisp")

(add-to-list 'load-path "~/.emacs.d/packages/squiggly-clojure/elisp/flycheck-clojure")
(add-to-list 'load-path "~/.emacs.d/packages/squiggly-clojure/elisp/typed-clojure")

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'clojure-mode-hook          #'cider-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook       #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook       #'subword-mode)

(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(eval-after-load "paredit" #'(show-paren-mode))

(autoload 'rainbow-delimiters-mode "rainbow-delimiters" "Emacs rainbow delimiters mode" t)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

(require 'dired-sidebar)
(require 'all-the-icons)
(require 'all-the-icons-dired)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(setq dired-sidebar-theme 'icons)

(require 'gruvbox)
(load-theme 'gruvbox-dark-hard t)

(require 'lsp-mode)
(require 'lsp-treemacs)
(require 'lsp-ui)
(require 'helm)
(require 'helm-config)
(require 'helm-lsp)
(require 'helm-projectile)
(require 'elixir-mode)
(require 'alchemist)
(require 'rust-mode)
(require 'yaml-mode)
(require 'clojure-mode)
(require 'cider)
(require 'helm-cider)
(require 'kaocha-runner)
(require 'paredit)
(require 'rainbow-delimiters)
(require 'projectile)
(require 'projectile-rails)
(require 'inf-ruby)
(require 'tide)
(require 'web-mode)
(require 'graphql-mode)
(require 'flycheck-pos-tip)
(require 'flycheck-popup-tip)
(require 'flycheck-flow)
(require 'flycheck-clj-kondo)
(require 'flycheck-clojure)
(require 'flycheck-swift)
(require 'swift-mode)
(require 'flow-minor-mode)
(require 'add-node-modules-path)
(require 'prettier-js)
(require 'nvm)
(require 'rubocop)
(require 'coffee-mode)

(put 'org-journal-dir 'safe-local-variable #'stringp)
(put 'browse-url-browser-function 'safe-local-variable #'symbolp)
(put 'browse-url-generic-program 'safe-local-variable #'stringp)

;(setq browse-url-browser-function 'browse-url-generic)
;(setq browse-url-generic-program "chrome")

(setq org-journal-dir "~/org/log/")
(setq org-journal-date-format "%Y-%m-%d")
(setq org-journal-file-type 'weekly)
(setq org-journal-file-format "%Y-%m-%d.orgj")

(require 'org-journal)

(add-to-list 'auto-mode-alist '("\\.orgj\\'" . org-journal-mode))

(setq org-export-backends '(ascii html icalendar md))

(require 'diff-hl)
(require 'diff-hl-margin)
(require 'diff-hl-dired)

(global-diff-hl-mode)
(diff-hl-dired-mode)
(diff-hl-margin-mode)

(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(add-to-list 'auto-mode-alist '("\\.graphql\\'" . graphql-mode))

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.erb\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))

(setq-default js-indent-level 2
  javascript-indent-level 2
  web-mode-code-indent-offset 2
  web-mode-markup-indent-offset 2
  web-mode-css-indent-offset 2
  web-mode-code-indent-offset 2
  web-mode-style-padding 2
  web-mode-script-padding 2
  css-indent-offset 2)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1))

(add-hook 'tide-mode-hook #'prettier-js-mode)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'javascript-mode-hook #'web-mode)
(add-hook 'js-mode-hook #'web-mode)
(add-hook 'js-mode-hook #'web-mode)

(add-hook 'web-mode-hook (lambda ()
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (flow-minor-enable-automatically)))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))

(add-hook 'web-mode-hook #'add-node-modules-path)
(add-hook 'web-mode-hook #'prettier-js-mode)

(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "ts" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

;; enable flow-minor-mode for js files
(flycheck-add-mode 'javascript-flow 'flow-minor-mode)
(flycheck-add-mode 'javascript-eslint 'flow-minor-mode)
(flycheck-add-next-checker 'javascript-flow 'javascript-eslint)

(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq flycheck-checker 'ruby-rubocop)
             (flycheck-mode 1)))

(defun flow/set-flow-executable ()
  (interactive)
  (let* ((os (pcase system-type
               ('darwin "osx")
               ('gnu/linux "linux64")
               (_ nil)))
         (root (locate-dominating-file  buffer-file-name  "node_modules/flow-bin"))
         (executable (car (file-expand-wildcards
                           (concat root "node_modules/flow-bin/*" os "*/flow")))))
    ;; These are not necessary for this package, but a good idea if you use
    ;; these other packages
    (setq-local flow-minor-default-binary executable)
    (setq-local flycheck-javascript-flow-executable executable)))

;; Set this to the mode you use, I use web-mode
(add-hook 'web-mode-hook #'flow/set-flow-executable t)

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(eval-after-load 'flycheck
  (if (display-graphic-p)
      (flycheck-pos-tip-mode)
    (flycheck-popup-tip-mode)))

(setq flycheck-pos-tip-display-errors-tty-function #'flycheck-popup-tip-show-popup
      flycheck-display-errors-function #'flycheck-pos-tip-error-messages)
(flycheck-pos-tip-mode)

(define-key paredit-mode-map (kbd "M-<up>") nil)
(define-key paredit-mode-map (kbd "M-<down>") nil)

(projectile-mode)
(projectile-rails-global-mode)
(helm-projectile-on)
(company-mode +1)

(eval-after-load 'projectile
  '(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
(eval-after-load 'projectile
  '(define-key projectile-mode-map (kbd "C-c f") 'projectile-find-file))

(add-to-list 'load-path "~/.emacs.d/packages/transient/lisp")
(load "~/.emacs.d/packages/transient/lisp/transient.el")

(add-to-list 'load-path "~/.emacs.d/packages/magit/lisp")
(load "~/.emacs.d/packages/magit/lisp/magit.el")
(global-set-key (kbd "C-x g") 'magit-status)

(add-hook 'after-save-hook 'magit-after-save-refresh-status t)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(add-to-list 'load-path "~/.emacs.d/packages/forge/lisp")
(load "~/.emacs.d/packages/forge/lisp/forge.el")

(with-eval-after-load 'magit
  (require 'forge))

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

(define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol)

(defun setup-clojure-mode ()
  (interactive)
  (lsp)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

(add-hook 'clojure-mode-hook #'setup-clojure-mode)

(defun setup-cider-mode ()
  (interactive)
  (helm-cider-mode 1)
  (flycheck-clojure-setup))

(add-hook 'cider-mode-hook #'setup-cider-mode)

(add-to-list 'auto-mode-alist '("\\.swift\\'" . swift-mode))

(eval-after-load 'lsp-mode
  (progn
    (require 'lsp-sourcekit)
    (setq lsp-sourcekit-executable "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp")))

(defun setup-swift-mode ()
  (interactive)
  (lsp)
  (flycheck-mode +1)
  (flycheck-swift-setup)
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

(add-hook 'swift-mode-hook #'setup-swift-mode)

(defun pbcopy ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))

(defun pbpaste ()
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

(defun pbcut ()
  (interactive)
  (pbcopy)
  (delete-region (region-beginning) (region-end)))

(global-set-key (kbd "C-c c") 'pbcopy)
(global-set-key (kbd "C-c v") 'pbpaste)
(global-set-key (kbd "C-c x") 'pbcut)

(defun gh-url-to-api (uri)
  (string-match "github.com/\\([[:word:]]+\\)/\\([[:word:]]+\\)/\\(issues\\|pull\\)/\\([[:digit:]]+\\)" uri)
  (let ((org (match-string 1 uri))
        (project (match-string 2 uri))
        (task (match-string 3 uri))
        (number (match-string 4 uri)))
    (format "https://api.github.com/repos/%s/%s/issues/%s"
            org project number)))

(defun gh-insert-metadata (result buf)
  (with-current-buffer buf
    (let ((title (plist-get result 'title))
          (number (plist-get result 'number))
          (html-url (plist-get result 'html_url))
          (labels (plist-get result 'labels)))
      (insert (format "%s " title))
      (insert (format "[[%s][#%s]] " html-url number))
      (insert (format ":%s: " number))
      (mapcar (lambda (arg) (insert (format ":%s: " (plist-get arg 'name)))) labels)
      (insert "\n"))))

(defun gh-fetch-cb (events buf)
  (goto-char url-http-end-of-headers)
  (let ((json-object-type 'plist)
        (json-key-type 'symbol)
        (json-array-type 'vector))
    (let ((result (json-read)))
      (gh-insert-metadata result buf))))

(defun gh-fetch-and-insert (api)
  (let ((url-request-extra-headers
         '(("Accept" . "application/vnd.github.v3+json"))))
    (url-retrieve
     api
     'gh-fetch-cb
     `(,(current-buffer)))))

(defun org-gh-metadata (uri)
  (interactive "sGitHub URL: ")
  (let ((api (gh-url-to-api uri)))
    (gh-fetch-and-insert api)))


