(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(global-set-key (kbd "C-x g") 'magit-status)

`(setq indent-tab-mode nil)`
